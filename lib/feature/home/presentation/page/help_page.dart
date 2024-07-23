import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quick_note/core/constans/app_assets.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/l10n.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(Insets.s),
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Image.asset(
                    AppAssets.logoRectangle,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: Insets.xl),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final appInfo = snapshot.data;
                      return Column(
                        children: [
                          _appInfoSegment(
                            context.l10n.app_info_app_name,
                            appInfo?.appName,
                            width,
                          ),
                          _appInfoSegment(
                            context.l10n.app_info_package_name,
                            appInfo?.packageName,
                            width,
                          ),
                          _appInfoSegment(
                            context.l10n.app_info_version,
                            appInfo?.version,
                            width,
                          ),
                          _appInfoSegment(
                            context.l10n.app_info_build_number,
                            appInfo?.buildNumber,
                            width,
                          ),
                        ],
                      );
                    }
                    return const Text("...");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appInfoSegment(String label, dynamic value, double width) {
    if (value != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Insets.xxs),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 300 + (width / 30),
            minWidth: 300,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
