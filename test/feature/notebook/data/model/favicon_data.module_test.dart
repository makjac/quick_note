import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/data/model/favicon_data.module.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';

void main() {
  group('FaviconDataModel', () {
    const url1 = 'https://example.com/favicon.svg';
    const url2 = 'https://example.com/favicon.ico';

    const sizes1 = '16x16';
    const sizes2 = '32x32';

    const type1 = 'image/svg+xml';
    const type2 = 'image/x-icon';

    test('should create an instance with the provided values', () {
      const model = FaviconDataModel(
        url: url1,
        sizes: sizes1,
        type: type1,
      );

      expect(model.url, equals(url1));
      expect(model.sizes, equals(sizes1));
      expect(model.type, equals(type1));
    });

    test('should create a model from an entity', () {
      const entity = FaviconData(
        url: url2,
        sizes: sizes2,
        type: type2,
      );
      final model = FaviconDataModel.fromEntity(entity);

      expect(model.url, equals(url2));
      expect(model.sizes, equals(sizes2));
      expect(model.type, equals(type2));
    });

    test('copyWith should return a model with updated values', () {
      const model = FaviconDataModel(
        url: url1,
        sizes: sizes1,
        type: type1,
      );
      final updatedModel = model.copyWith(
        url: url2,
        sizes: sizes2,
      );

      expect(updatedModel.url, equals(url2));
      expect(updatedModel.sizes, equals(sizes2));
      expect(updatedModel.type, equals(type1)); // Type should remain the same
    });

    test('compareTo should prioritize .svg over other types', () {
      const svgModel = FaviconDataModel(url: url1);
      const icoModel = FaviconDataModel(url: url2);

      expect(svgModel.compareTo(icoModel),
          isNegative); // .svg should be considered less than .ico
      expect(icoModel.compareTo(svgModel),
          isPositive); // .ico should be considered greater than .svg
    });

    test('compareTo should compare based on size and URL length', () {
      const model1 = FaviconDataModel(url: url1, sizes: sizes1); // 16
      const model2 = FaviconDataModel(url: url2, sizes: sizes2); // 32

      expect(model1.compareTo(model2), isNegative); // 32 is greater than 16
      expect(model2.compareTo(model1), isPositive); // 16 is less than 32
    });

    test('props should return the correct list of properties', () {
      const model = FaviconDataModel(
        url: url1,
        sizes: sizes1,
        type: type1,
      );

      expect(model.props, equals([url1, sizes1, type1]));
    });

    test('props should be different for different values', () {
      const model1 = FaviconDataModel(
        url: url1,
        sizes: sizes1,
        type: type1,
      );
      const model2 = FaviconDataModel(
        url: url2,
        sizes: sizes2,
        type: type2,
      );

      expect(model1.props, isNot(equals(model2.props)));
    });
  });
}
