import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/observers.dart';
import 'package:navigator_bicycle/navigator/pages_builder.dart';
import 'package:navigator_bicycle/navigator/route_config.dart';
import 'package:navigator_bicycle/navigator/routes.dart';
import 'package:navigator_bicycle/pages/unknown_page.dart';

class AppRouterDelegate extends RouterDelegate<IRouteConfig>
    with ChangeNotifier {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _appRouter = AppRouter();

  IRouteConfig? _currentConfiguration;

  @override
  Widget build(BuildContext context) {
    return PagesBuilder(
      router: _appRouter,
      configuration: currentConfiguration,
      builder: (context, pages) {
        return Navigator(
          key: _navigatorKey,
          observers: [
            PageObserver(),
          ],
          pages: pages,
          onUnknownRoute: (settings) => MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => const UnknownPage(),
          ),
          onPopPage: (Route<Object?> route, Object? result) {
            if (!route.didPop(result)) {
              return false;
            }
            setNewRoutePath(
              currentConfiguration.previous ?? NotFoundRouteConfig(),
            );
            return true;
          },
        );
      },
    );
  }

  @override
  Future<bool> popRoute() {
    try {
      final navigatorState = _navigatorKey.currentState;

      if (navigatorState == null) {
        return SynchronousFuture(false);
      }

      return navigatorState.maybePop().then<bool>(
        (value) {
          return true;
        },
        onError: (Object error, StackTrace stackTrace) => false,
      );
    } on Object {
      return SynchronousFuture(false);
    }
  }

  @override
  Future<void> setNewRoutePath(IRouteConfig configuration) {
    if (_currentConfiguration == configuration) {
      return SynchronousFuture<void>(null);
    }

    _currentConfiguration = configuration;
    notifyListeners();

    return SynchronousFuture<void>(null);
  }

  @override
  IRouteConfig get currentConfiguration {
    final configuration = _currentConfiguration;
    if (configuration == null) {
      throw UnsupportedError('Изначальная конфигурация не установлена');
    }
    return configuration;
  }
}
