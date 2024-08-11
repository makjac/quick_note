import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/app_assets.dart';

void main() {
  group('AppAssets', () {
    test('should have correct logo path', () {
      expect(AppAssets.logo, "assets/logo/quick_note.png");
    });
  });
}
