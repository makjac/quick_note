import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quick_note/core/service/admob/ad_mob_service.dart';
import 'package:quick_note/injection_container.dart';

class HomePageAdBanner extends StatefulWidget {
  const HomePageAdBanner({super.key});

  @override
  State<HomePageAdBanner> createState() => _HomePageAdBannerState();
}

class _HomePageAdBannerState extends State<HomePageAdBanner> {
  final AdMobService _adMobService = locator<AdMobService>();
  BannerAd? _banner;

  @override
  void initState() {
    _loadBanner();
    super.initState();
  }

  void _loadBanner() {
    _banner = _adMobService.createBannerAd();
    _banner!.load();
  }

  @override
  Widget build(BuildContext context) {
    if (_banner == null) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      width: _banner!.size.width.toDouble(),
      height: _banner!.size.height.toDouble(),
      child: AdWidget(ad: _banner!),
    );
  }
}
