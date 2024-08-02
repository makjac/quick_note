import 'package:flutter/material.dart';
import 'package:quick_note/analytics/service/analytics_manager.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/router/app_routes.dart';

class AnalyticsRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    final analytics = locator<AnalyticsManager>();

    if (route.settings.name != null) {
      analytics.logScreenView(route.settings.name ?? AppRoutes.unknown.name);
    }
  }
}