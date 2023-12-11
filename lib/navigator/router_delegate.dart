import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_bicycle/navigator/bloc/navigator_bloc.dart';
import 'package:navigator_bicycle/navigator/observers.dart';
import 'package:navigator_bicycle/navigator/pages_builder.dart';
import 'package:navigator_bicycle/navigator/route_config.dart';
import 'package:navigator_bicycle/navigator/routes.dart';
import 'package:navigator_bicycle/pages/unknown_page.dart';

class AppRouterDelegate extends RouterDelegate<IRouteConfig>
    with ChangeNotifier {
  AppRouterDelegate({
    required NavigatorBloc navigatorBloc,
  }) : _navigatorBloc = navigatorBloc;

  final _navigatorKey = GlobalKey<NavigatorState>();
  final _appRouter = AppRouter();

  final NavigatorBloc _navigatorBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigatorBloc>.value(
      value: _navigatorBloc,
      child: BlocConsumer<NavigatorBloc, NavigatorBlocState>(
        listener: (context, state) {
          // TODO: Слушать события блока навигатор
          log('''
          ===
          
          URI = ${state.configuration.uri}\n
          Stack = ${state.routesStack.map((e) => e.name).join(' , ')}
                    
          ====
          ''');
        },
        builder: (context, state) => PagesBuilder(
          router: _appRouter,
          routes: state.routesStack,
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

              ///  Перехватывает нажатие кнопки назад в приложении
              onPopPage: (Route<Object?> route, Object? result) {
                if (!route.didPop(result)) {
                  return false;
                }

                _navigatorBloc.add(const NavigatorBlocEvent.pop());

                return true;
              },
            );
          },
        ),
      ),
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

  /// Вызывается при изменении пути в адресной строке или просто со стороны ОС
  @override
  Future<void> setNewRoutePath(IRouteConfig configuration) {
    _navigatorBloc.add(NavigatorBlocEvent.applyConfiguration(configuration));

    notifyListeners();

    return SynchronousFuture<void>(null);
  }
}
