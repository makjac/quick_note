class UrlHelper {
  static const String urlPattern = r'^(https?:\/\/)?' // protokół opcjonalny
      r'^(https?:\/\/)?' // Optional protocol (http or https)
      r'((([a-zA-Z\d]([a-zA-Z\d-]*[a-zA-Z\d])*)\.)+[a-zA-Z]{2,}' // Domain (e.g., example.com or sub.example.com)
      r'|((\d{1,3}\.){3}\d{1,3})' // IP address (e.g., 192.168.1.1)
      r'|(([a-zA-Z0-9\u00a1-\uffff][a-zA-Z0-9\u00a1-\uffff-]{0,62})?[a-zA-Z0-9\u00a1-\uffff]\.)+([a-zA-Z\u00a1-\uffff]{2,}\.?))' // International domain (e.g., example.co.uk or example.世界)
      r'(:\d{2,5})?' // Optional port (e.g., :8080)
      r'(\/[a-zA-Z\d%_.~+=:@-]*)*' // Path (must not have consecutive slashes or invalid characters)
      r'(\?[;&a-zA-Z\d%_.~+=-]*)?' // Optional query string (e.g., ?key=value&anotherkey=anothervalue)
      r'(#[-a-zA-Z\d_]*)?$'; // Optional fragment (e.g., #section1)

  static final RegExp _urlRegExp = RegExp(urlPattern);
  static bool isValidUrl(String url) {
    return _urlRegExp.hasMatch(url);
  }

  static String completeUrl(String url) {
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      if (!url.startsWith("www.")) {
        return "http://www.$url".toLowerCase();
      } else {
        return "http://$url".toLowerCase();
      }
    }

    return url;
  }

  static String extractDomain(String url) {
    final Uri uri = Uri.parse(completeUrl(url));
    return uri.host;
  }

static Future<void> launchUrl(String url) async {
    final uri = Uri.parse(url);

    final canLaunch = await ul.canLaunchUrl(uri);
    if (!canLaunch) return;

    await ul.launchUrl(uri, mode: ul.LaunchMode.externalApplication);
  }
}
