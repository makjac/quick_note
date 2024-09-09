import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_note/core/service/analytics/service/analytics_service.dart';
import 'package:quick_note/router/analytics_route_observer.dart';
import 'package:quick_note/router/app_routes.dart';
import 'package:quick_note/injection_container.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  late AnalyticsRouteObserver analyticsRouteObserver;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analyticsRouteObserver = AnalyticsRouteObserver();
    locator.registerSingleton<AnalyticsService>(mockAnalyticsService);
  });

  tearDown(() {
    locator.reset();
  });

  test('should log screen view when a route is pushed', () async {
    final route = MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.homePage.name),
        builder: (_) => Container());
    final previousRoute = MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.notesPage.name),
        builder: (_) => Container());

    analyticsRouteObserver.didPush(route, previousRoute);

    verify(mockAnalyticsService.logScreenView(AppRoutes.homePage.name))
        .called(1);
  });
}
