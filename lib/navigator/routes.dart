import 'package:flutter/material.dart';
import 'package:navigator_bicycle/pages/about_page.dart';
import 'package:navigator_bicycle/pages/home_page.dart';
import 'package:navigator_bicycle/pages/settings_page.dart';
import 'package:navigator_bicycle/pages/unknown_page.dart';

// class AppPage<T> extends Page<T> {
//   const AppPage({
//     required this.pageName,
//     required this.builder,
//     super.arguments,
//   }) : super(name: pageName);
//
//   final String pageName;
//   final WidgetBuilder builder;
//
//   /// Добавить парсинг роута из строки
//
//   @override
//   Route<T> createRoute(BuildContext context) {
//     return MaterialPageRoute(
//       builder: builder,
//       settings: this,
//     );
//   }
// }

class AppRoutes {
  // static const main = '/';
  static const home = 'home';
  static const settings = 'settings';
  static const about = 'about';
  static const notFound = 'notFound';

// static const mainPage = AppPage(name: main, builder: () {});
}

class AppRouter {
  Map<String, WidgetBuilder> get routes => {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.settings: (context) => const SettingsPage(),
        AppRoutes.about: (context) => const AboutPage(),
        AppRoutes.notFound: (context) => const UnknownPage(),
      };
}
