import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/utils/url_helper.dart';

void main() {
  group('UrlHelper', () {
    group('isValidUrl', () {
      test('returns true for valid URLs', () {
        expect(UrlHelper.isValidUrl('http://www.example.com'), isTrue);
        expect(UrlHelper.isValidUrl('https://example.com'), isTrue);
        expect(UrlHelper.isValidUrl('http://sub.example.com'), isTrue);
        expect(UrlHelper.isValidUrl('http://192.168.1.1'), isTrue);
        expect(UrlHelper.isValidUrl('http://example.co.uk'), isTrue);
      });

      test('returns false for invalid URLs', () {
        expect(UrlHelper.isValidUrl('htp://example.com'), isFalse);
        expect(UrlHelper.isValidUrl('http://-example.com'), isFalse);
        expect(UrlHelper.isValidUrl('http://example..com'), isFalse);
        expect(UrlHelper.isValidUrl('http://.com'), isFalse);
        expect(UrlHelper.isValidUrl('example'), isFalse);
      });
    });

    group('completeUrl', () {
      test('adds http:// and www. when necessary', () {
        expect(UrlHelper.completeUrl('example.com'), 'http://www.example.com');
        expect(
            UrlHelper.completeUrl('www.example.com'), 'http://www.example.com');
        expect(
            UrlHelper.completeUrl('http://example.com'), 'http://example.com');
        expect(UrlHelper.completeUrl('https://example.com'),
            'https://example.com');
      });

      test('does not alter URLs with http:// or https://', () {
        expect(UrlHelper.completeUrl('http://www.example.com'),
            'http://www.example.com');
        expect(UrlHelper.completeUrl('https://www.example.com'),
            'https://www.example.com');
      });
    });

    group('extractDomain', () {
      test('extracts domain from URLs', () {
        expect(UrlHelper.extractDomain('http://www.example.com/path'),
            'www.example.com');
        expect(UrlHelper.extractDomain('example.com/path'), 'www.example.com');
        expect(
            UrlHelper.extractDomain('http://example.com/path'), 'example.com');
        expect(UrlHelper.extractDomain('https://sub.example.co.uk/path'),
            'sub.example.co.uk');
      });

      test('handles URLs without a path', () {
        expect(UrlHelper.extractDomain('http://example.com'), 'example.com');
        expect(UrlHelper.extractDomain('https://www.example.com'),
            'www.example.com');
      });
    });
  });
}
