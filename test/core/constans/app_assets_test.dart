import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/app_assets.dart';

void main() {
  group('AppAssets', () {
    test('should have correct logo path', () {
      expect(AppAssets.logo, "assets/logo/quick_note.png");
    });

    test('should have correct logoSVG path', () {
      expect(AppAssets.logoSVG, "assets/svg/quick_note.svg");
    });

    test('should have correct logoBoxSVG path', () {
      expect(AppAssets.logoBoxSVG, "assets/svg/quickNote_box.svg");
    });
  });
}
