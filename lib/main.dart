import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/route_parser.dart';
import 'package:navigator_bicycle/navigator/router_delegate.dart';

import 'navigator/bloc/navigator_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NavigatorBloc _navigatorBloc;
  late final AppRouterDelegate _delegate;
  final _parser = AppRouteParser();

  @override
  void initState() {
    super.initState();

    _navigatorBloc = NavigatorBloc();
    _delegate = AppRouterDelegate(navigatorBloc: _navigatorBloc);
  }

  @override
  Widget build(BuildContext context) {
    /// Используем конструктор .router для работы с Navigator 2.0
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
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
