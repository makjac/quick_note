// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:image/image.dart';
import 'package:quick_note/feature/notebook/data/model/favicon_data.module.dart';

/// Abstract class for managing remote bookmark data sources related to favicons.
abstract class BookmarksRemoteDatasource {
  /// Fetches the URL of the best favicon for a given URL.
  ///
  /// This method identifies the most suitable favicon (usually the highest quality or most relevant one) for the specified URL.
  ///
  /// Example usage:
  /// ```dart
  /// final bestFaviconUrl = await datasource.fetchBestFaviconUrl('https://example.com');
  /// print('Best Favicon URL: $bestFaviconUrl');
  /// ```
  Future<String?> fetchBestFaviconUrl(String url);

  /// Fetches all available favicon URLs for a given URL.
  ///
  /// This method retrieves all favicon URLs found on the specified webpage. The result may include favicons of different sizes and types.
  ///
  /// Example usage:
  /// ```dart
  /// final allFavicons = await datasource.fetchAllFaviconUrls('https://example.com');
  /// for (var favicon in allFavicons) {
  ///   print('Favicon URL: ${favicon.url}, Sizes: ${favicon.sizes}, Type: ${favicon.type}');
  /// }
  /// ```
  Future<List<FaviconDataModel>> fetchAllFaviconUrls(String url);

  /// Fetches favicons of a specific type for a given URL.
  ///
  /// This method filters favicons based on their MIME type (e.g., 'image/png', 'image/svg+xml') for the specified URL.
  ///
  /// Example usage:
  /// ```dart
  /// final pngFavicons = await datasource.fetchFaviconsByType('https://example.com', 'image/png');
  /// for (var favicon in pngFavicons) {
  ///   print('PNG Favicon URL: ${favicon.url}');
  /// }
  /// ```
  Future<List<FaviconDataModel>> fetchFaviconsByType(String url, String type);

  /// Fetches favicons within a specified size range for a given URL.
  ///
  /// This method retrieves favicons that fall within the given size range (e.g., 16 to 32 pixels) for the specified URL.
  ///
  /// Example usage:
  /// ```dart
  /// final faviconsBySize = await datasource.fetchFaviconsBySizeRange('https://example.com', 16, 32);
  /// for (var favicon in faviconsBySize) {
  ///   print('Favicon URL: ${favicon.url}, Sizes: ${favicon.sizes}');
  /// }
  /// ```
  Future<List<FaviconDataModel>> fetchFaviconsBySizeRange(
      String url, int minSize, int maxSize);
  Future<bool> isValidFaviconUrl(String url);
  Future<List<FaviconDataModel>> fetchFaviconsByDomain(String domain);
}
class BookmarksRemoteDatasourceImpl implements BookmarksRemoteDatasource {
  BookmarksRemoteDatasourceImpl({http.Client? client})
      : client = client ?? http.Client();

  final http.Client client;

  @override
  Future<String?> fetchBestFaviconUrl(String url) async {
    var favicons = await fetchAllFaviconUrls(url);
    if (favicons.isEmpty) return null;

    favicons.sort();
    return favicons.first.url;
  }

  @override
  Future<List<FaviconDataModel>> fetchAllFaviconUrls(String url) async {
    var favicons = <FaviconDataModel>[];
    var iconUrls = <String>[];

    var uri = Uri.parse(url);
    var document = html_parser.parse((await client.get(uri)).body);

    for (var rel in ['icon', 'shortcut icon', 'apple-touch-icon']) {
      for (var iconTag in document.querySelectorAll("link[rel='$rel']")) {
        if (iconTag.attributes['href'] != null) {
          var iconUrl = _sanitizeUrl(iconTag.attributes['href']!.trim(), uri);
          if (await _verifyImage(iconUrl)) {
            iconUrls.add(iconUrl);
          }
        }
      }
    }

    var iconUrl = '${uri.scheme}://${uri.host}/favicon.ico';
    if (await _verifyImage(iconUrl)) {
      iconUrls.add(iconUrl);
    }

    iconUrls = iconUrls.toSet().toList();

    for (var iconUrl in iconUrls) {
      if (iconUrl.endsWith('.svg')) {
        favicons.add(FaviconDataModel(url: iconUrl));
        continue;
      }

      if (iconUrl.endsWith('.ico')) {
        favicons.add(FaviconDataModel(url: iconUrl, sizes: '16x16'));
        continue;
      }

      var image = decodeImage((await client.get(Uri.parse(iconUrl))).bodyBytes);
      if (image != null) {
        favicons.add(FaviconDataModel(
            url: iconUrl, sizes: '${image.width}x${image.height}'));
      }
    }

    return favicons;
  }

  @override
  Future<List<FaviconDataModel>> fetchFaviconsByType(
      String url, String type) async {
    var favicons = await fetchAllFaviconUrls(url);
    return favicons.where((favicon) => favicon.type == type).toList();
  }

  @override
  Future<List<FaviconDataModel>> fetchFaviconsBySizeRange(
      String url, int minSize, int maxSize) async {
    var favicons = await fetchAllFaviconUrls(url);
    return favicons.where((favicon) {
      var size = _parseSize(favicon.sizes);
      return size >= minSize && size <= maxSize;
    }).toList();
  }

  @override
  Future<bool> isValidFaviconUrl(String url) async {
    return await _verifyImage(url);
  }

  @override
  Future<List<FaviconDataModel>> fetchFaviconsByDomain(String domain) async {
    var uri = Uri.parse(domain);
    var url = '${uri.scheme}://${uri.host}';
    return await fetchAllFaviconUrls(url);
  }
  String _sanitizeUrl(String url, Uri baseUri) {
    if (url.startsWith('//')) {
      return '${baseUri.scheme}:$url';
    }

    if (url.startsWith('/')) {
      return '${baseUri.scheme}://${baseUri.host}$url';
    }

    if (!url.startsWith('http')) {
      return '${baseUri.scheme}://${baseUri.host}/$url';
    }

    return url.split('?').first;
  }
  Future<bool> _verifyImage(String url) async {
    var response = await client.get(Uri.parse(url));

    var contentType = response.headers['content-type'];
    if (contentType == null || !contentType.contains('image')) return false;

    if (url.endsWith('.ico')) {
      if (response.bodyBytes.length < 4) return false;
      if (!_verifySignature(response.bodyBytes, [0, 0, 1, 0]) &&
          !_verifySignature(
              response.bodyBytes, [137, 80, 78, 71, 13, 10, 26, 10])) {
        return false;
      }
    }

    return response.statusCode == 200 &&
        (response.contentLength ?? 0) > 0 &&
        contentType.contains('image');
  }
  bool _verifySignature(Uint8List bodyBytes, List<int> signature) {
    var fileSignature = bodyBytes.sublist(0, signature.length);
    for (var i = 0; i < fileSignature.length; i++) {
      if (fileSignature[i] != signature[i]) return false;
    }
    return true;
  }
  int _parseSize(String? size) {
    if (size == null) return 16;
    var sizeParts = size.split('x');
    if (sizeParts.length == 2) {
      return int.parse(sizeParts[0]);
    }
    return 16;
  }
  }
