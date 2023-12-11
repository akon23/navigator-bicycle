import 'package:flutter/material.dart';
import 'package:navigator_bicycle/pages/about_page.dart';
import 'package:navigator_bicycle/pages/home_page.dart';
import 'package:navigator_bicycle/pages/settings_page.dart';
import 'package:navigator_bicycle/pages/tabs_page.dart';
import 'package:navigator_bicycle/pages/unknown_page.dart';
import 'package:navigator_bicycle/utils/extentions/navigator_extensions.dart';

class AppRouteModel<T> {
  const AppRouteModel(this.name) : arguments = null;

  AppRouteModel.args(this.name, {this.arguments});

  final String name;

  // TODO: Абстрактный класс для аргументов?
  /// Тогда в state [IRouteConfig] будет Map<String, PageArguments?>
  final T? arguments;

  AppRouteModel<T> withArguments(T arguments) {
    return AppRouteModel<T>.args(name, arguments: arguments);
  }

  T getRequiredArguments(BuildContext context) {
    return context.navBloc.state.routesStack
        .firstWhere((route) => route.name == name)
        .arguments;
  }
}

class AppRoutes {
  static const _mainPath = '/';
  static const _homePath = 'home';
  static const _settingsPath = 'settings';
  static const _aboutPath = 'about';
  static const _notFoundPath = 'notFound';
  static const _tabsPagePath = 'tabs';

  static const main = AppRouteModel(_mainPath);

  static const home = AppRouteModel(_homePath);

  static const settings = AppRouteModel<int>(_settingsPath);

  static const about = AppRouteModel<String>(_aboutPath);

  static const notFound = AppRouteModel(_notFoundPath);

  static const tabsPage = AppRouteModel<int>(_tabsPagePath);
}

class AppRouter {
  Map<String, WidgetBuilder> get routes => {
        AppRoutes.home.name: (context) => const HomePage(),
        AppRoutes.settings.name: (context) {
          final args = AppRoutes.settings.getRequiredArguments(context);

          return SettingsPage(args: args);
        },
        AppRoutes.about.name: (context) {
          final args = AppRoutes.about.getRequiredArguments(context);

          return AboutPage(args: args);
        },
        AppRoutes.notFound.name: (context) => const UnknownPage(),
        AppRoutes.tabsPage.name: (context) {
          final args = AppRoutes.tabsPage.getRequiredArguments(context);

          return TabsPage(tabIndex: args);
        }
      };
}
