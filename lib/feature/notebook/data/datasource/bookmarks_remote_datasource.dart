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
