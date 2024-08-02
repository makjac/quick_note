import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  factory AdMobService() => _instance;

  AdMobService._({MobileAds? mobileAds})
      : _mobileAds = mobileAds ?? MobileAds.instance;

  static final _instance = AdMobService._();

  final MobileAds _mobileAds;

  Future<void> initialize() async {
    await _mobileAds.initialize();
  }

  String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5166777989324584/8485435308';
    } else if (Platform.isIOS) {
      return null;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  BannerAdListener getBannerAdListener() {
    return BannerAdListener(
      onAdLoaded: (ad) {},
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
      },
      onAdOpened: (ad) {},
      onAdClosed: (ad) {},
      onAdImpression: (ad) {},
      onAdClicked: (ad) {},
    );
  }
}
