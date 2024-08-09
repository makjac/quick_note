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
  }
