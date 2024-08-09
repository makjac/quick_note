// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:image/image.dart';
import 'package:quick_note/feature/notebook/data/model/favicon_data.module.dart';
abstract class BookmarksRemoteDatasource {
  Future<String?> fetchBestFaviconUrl(String url);
  Future<List<FaviconDataModel>> fetchAllFaviconUrls(String url);
  Future<List<FaviconDataModel>> fetchFaviconsByType(String url, String type);
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
  }
