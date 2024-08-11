import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';

void main() {
  group('FaviconData', () {
    const url1 = 'https://example.com/favicon.ico';
    const sizes1 = '16x16';
    const type1 = 'image/x-icon';

    const url2 = 'https://example.com/favicon.ico';
    const sizes2 = '32x32';
    const type2 = 'image/png';

    test('should create an instance with the provided values', () {
      const faviconData = FaviconData(
        url: url1,
        sizes: sizes1,
        type: type1,
      );

      expect(faviconData.url, equals(url1));
      expect(faviconData.sizes, equals(sizes1));
      expect(faviconData.type, equals(type1));
    });

    test('should be equal to another FaviconData with the same values', () {
      const faviconData1 = FaviconData(
        url: url1,
        sizes: sizes1,
        type: type1,
      );
      const faviconData2 = FaviconData(
        url: url1,
        sizes: sizes1,
        type: type1,
      );

      expect(faviconData1, equals(faviconData2));
    });

    test('should not be equal to another FaviconData with different values',
        () {
      const faviconData1 = FaviconData(
        url: url1,
        sizes: sizes1,
        type: type1,
      );
      const faviconData2 = FaviconData(
        url: url2,
        sizes: sizes2,
        type: type2,
      );

      expect(faviconData1, isNot(equals(faviconData2)));
    });

    test('props should return the correct list of properties', () {
      const faviconData = FaviconData(
        url: url1,
        sizes: sizes1,
        type: type1,
      );

      expect(faviconData.props, equals([url1, sizes1, type1]));
    });

    test('props should be different for different values', () {
      const faviconData1 = FaviconData(
        url: url1,
        sizes: sizes1,
        type: type1,
      );
      const faviconData2 = FaviconData(
        url: url2,
        sizes: sizes2,
        type: type2,
      );

      expect(faviconData1.props, isNot(equals(faviconData2.props)));
    });
  });
}
