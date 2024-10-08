import 'package:url_launcher/url_launcher.dart' as ul;

/// A helper class for handling URLs.
class UrlHelper {
  /// A regular expression pattern for validating URLs.
  static const String urlPattern = r'^(https?:\/\/)?' // protokół opcjonalny
      r'^(https?:\/\/)?' // Optional protocol (http or https)
      r'((([a-zA-Z\d]([a-zA-Z\d-]*[a-zA-Z\d])*)\.)+[a-zA-Z]{2,}' // Domain (e.g., example.com or sub.example.com)
      r'|((\d{1,3}\.){3}\d{1,3})' // IP address (e.g., 192.168.1.1)
      r'|(([a-zA-Z0-9\u00a1-\uffff][a-zA-Z0-9\u00a1-\uffff-]{0,62})?[a-zA-Z0-9\u00a1-\uffff]\.)+([a-zA-Z\u00a1-\uffff]{2,}\.?))' // International domain (e.g., example.co.uk or example.世界)
      r'(:\d{2,5})?' // Optional port (e.g., :8080)
      r'(\/[a-zA-Z\d%_.~+=:@,;&!$*\()\\-]*)*' // Path (must not have consecutive slashes or invalid characters)
      r'(\?[a-zA-Z\d%_.~+=:@,;&!$*\()\\-]*)?' // Optional query string (e.g., ?key=value&anotherkey=anothervalue)
      r'(#[-a-zA-Z\d_]*)?$'; // Optional fragment (e.g., #section1)

  static final RegExp _urlRegExp = RegExp(urlPattern);

  /// Checks if the given [url] is a valid URL.
  ///
  /// Returns `true` if the [url] matches the URL pattern, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = UrlHelper.isValidUrl('http://www.example.com');
  /// print(isValid); // true
  /// ```
  static bool isValidUrl(String url) {
    return _urlRegExp.hasMatch(url);
  }

  /// Completes the given [url] by adding 'http://www.' if necessary.
  ///
  /// If the [url] does not start with 'http://' or 'https://', it adds 'http://'.
  /// If the [url] does not start with 'www.', it adds 'www.' as well.
  ///
  /// Example:
  /// ```dart
  /// String completedUrl = UrlHelper.completeUrl('example.com');
  /// print(completedUrl); // http://www.example.com
  ///
  /// completedUrl = UrlHelper.completeUrl('www.example.com');
  /// print(completedUrl); // http://www.example.com
  ///
  /// completedUrl = UrlHelper.completeUrl('http://example.com');
  /// print(completedUrl); // http://example.com
  ///
  /// completedUrl = UrlHelper.completeUrl('https://example.com');
  /// print(completedUrl); // https://example.com
  /// ```
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

  /// Extracts the domain from the given [url].
  ///
  /// If the [url] does not start with 'http://' or 'https://', it is first completed
  /// using [completeUrl], then the domain is extracted.
  ///
  /// Example:
  /// ```dart
  /// String domain = UrlHelper.extractDomain('http://www.example.com/path');
  /// print(domain); // www.example.com
  ///
  /// domain = UrlHelper.extractDomain('example.com/path');
  /// print(domain); // www.example.com
  ///
  /// domain = UrlHelper.extractDomain('http://example.com/path');
  /// print(domain); // example.com
  /// ```
  static String extractDomain(String url) {
    final Uri uri = Uri.parse(completeUrl(url));
    return uri.host;
  }

  /// Launches the provided URL.
  ///
  /// This method takes a [url] as a parameter and launches it using the [ul.launchUrl] method.
  /// It first parses the [url] into a [Uri] object using the [Uri.parse] method.
  /// Then, it checks if the URL can be launched using the [ul.canLaunchUrl] method.
  /// If the URL cannot be launched, the method returns without performing any further actions.
  /// If the URL can be launched, it calls the [ul.launchUrl] method with the parsed [uri] and the launch mode set to [ul.LaunchMode.externalApplication].
  ///
  /// Example usage:
  /// ```dart
  /// await launchUrl('https://example.com');
  /// ```
  ///
  /// Throws an exception if the [url] is invalid or if an error occurs while launching the UR
  static Future<void> launchUrl(String url) async {
    final uri = Uri.parse(url);

    final canLaunch = await ul.canLaunchUrl(uri);
    if (!canLaunch) return;

    await ul.launchUrl(uri, mode: ul.LaunchMode.externalApplication);
  }
}
