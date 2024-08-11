import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/app_constans.dart';

void main() {
  group('AppConstants', () {
    test('should have correct mobileSize value', () {
      expect(AppConstans.mobileSize, 750.0);
    });
  });
}
