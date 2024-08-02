import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  factory AdMobService() => _instance;

  AdMobService._({MobileAds? mobileAds})
      : _mobileAds = mobileAds ?? MobileAds.instance;

  static final _instance = AdMobService._();

  final MobileAds _mobileAds;
}
