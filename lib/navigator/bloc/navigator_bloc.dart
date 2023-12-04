import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navigator_bicycle/navigator/route_config.dart';
import 'package:navigator_bicycle/navigator/routes.dart';

part 'navigator_event.dart';

part 'navigator_state.dart';

part 'navigator_bloc.freezed.dart';

class NavigatorBloc extends Bloc<NavigatorBlocEvent, NavigatorBlocState> {
  NavigatorBloc()
      : super(
          NavigatorBlocState(
            configuration: HomeRouteConfig(),
          ),
        ) {
    on<NavigatorBlocEvent>(
      (event, emit) => switch (event) {
        _PushEvent() => _handlePushEvent(event, emit),
        _PopEvent() => _handlePopEvent(event, emit),
        _UpdateStackEvent() => _handleUpdateStackEvent(event, emit),
        _ApplyConfigurationEvent() =>
          _handleApplyConfigurationEvent(event, emit),
      },
      transformer: sequential(),
    );
  }

  void _handlePushEvent(
    _PushEvent event,
    Emitter<NavigatorBlocState> emit,
  ) {
    final newConfig = state.configuration.add(event.route);
    final newStack = [...state.routesStack, event.route];

    SystemNavigator.routeInformationUpdated(
      uri: newConfig.uri,
      state: newConfig.state,
    );

    // TODO: Добавлять просто в стек и потом гененрировать config по этому стеку ?

    emit(
      NavigatorBlocState(
        configuration: newConfig,
        routesStack: newStack,
      ),
    );
  }

  void _handlePopEvent(
    _PopEvent event,
    Emitter<NavigatorBlocState> emit,
  ) {
    final newConfig = state.configuration.previous;
    if (newConfig == null) {
      return;
    }
    final newStack = _stackFromCurrentConfig(newConfig);

    SystemNavigator.routeInformationUpdated(
      uri: newConfig.uri,
      state: newConfig.state,
    );

    emit(
      NavigatorBlocState(
        configuration: newConfig,
        routesStack: newStack,
      ),
    );
  }

  void _handleUpdateStackEvent(
    _UpdateStackEvent event,
    Emitter<NavigatorBlocState> emit,
  ) {
    final newConfig = _configFromStack(event.stack);

    SystemNavigator.routeInformationUpdated(
      uri: newConfig.uri,
      state: newConfig.state,
    );

    emit(
      NavigatorBlocState(
        configuration: newConfig,
        routesStack: event.stack,
      ),
    );
  }

  void _handleApplyConfigurationEvent(
    _ApplyConfigurationEvent event,
    Emitter<NavigatorBlocState> emit,
  ) {
    final newStack = _stackFromCurrentConfig(event.configuration);

    SystemNavigator.routeInformationUpdated(
      uri: event.configuration.uri,
      state: event.configuration.state,
    );

    // TODO: Тут можно потерять предыдущий стейт конфигурации

    emit(
      NavigatorBlocState(
        configuration: event.configuration,
        routesStack: newStack,
      ),
    );
  }

  IRouteConfig _configFromStack(List<AppRouteModel> routes) {
    if (routes.isEmpty) {
      return HomeRouteConfig();
    }

    final state = {for (var e in routes) e.name: e.arguments};
    final configUri = Uri(path: routes.map((e) => e.name).join('/'));

    return BaseRouteConfig(
      uri: configUri,
      state: state,
    );
  }

  List<AppRouteModel> _stackFromCurrentConfig(IRouteConfig configuration) {
    final pagesNames = configuration.uri.pathSegments;

    final routes = pagesNames
        .map<AppRouteModel>((name) => AppRouteModel.args(
              name,
              arguments: configuration.state?[name],
            ))
        .toList();

    if (routes.isEmpty) {
      routes.add(AppRoutes.home);
    }

    return routes;
  }
}
