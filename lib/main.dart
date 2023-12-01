import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/route_parser.dart';
import 'package:navigator_bicycle/navigator/router_delegate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _delegate = AppRouterDelegate();
  final _parser = AppRouteParser();

  @override
  Widget build(BuildContext context) {
    /// Используем конструктор .router для работы с Navigator 2.0
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      /// routeInformationProvider нужен для работы с интентами навигации от платформы
      /// Он принимает их и передает в routeInformationParser
      ///
      /// Он кастомный не особо нужен,
      /// нам сразу дается нормальная реализация для работы с платформой
      // routeInformationProvider: PlatformRouteInformationProvider(
      //   initialRouteInformation: RouteInformation(uri: Uri()),
      // ),

      ///
      ///
      ///
      routerDelegate: _delegate,

      ///
      ///
      ///
      routeInformationParser: _parser,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(),
    );
  }
}
