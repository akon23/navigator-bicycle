import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/route_config.dart';

class AppRouteParser extends RouteInformationParser<IRouteConfig> {
  @override
  Future<IRouteConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    try {
      if (routeInformation is IRouteConfig) {
        return SynchronousFuture<IRouteConfig>(routeInformation);
      }

      if (routeInformation.uri.path == '/') {
        return SynchronousFuture<IRouteConfig>(HomeRouteConfig());
      } else {
        final state = routeInformation.state;
        if (state is Map<String, Object?>) {
          return SynchronousFuture<IRouteConfig>(
            BaseRouteConfig(uri: routeInformation.uri, state: state),
          );
        } else {
          return SynchronousFuture<IRouteConfig>(
            BaseRouteConfig(uri: routeInformation.uri),
          );
        }
      }
    } on Object {
      return SynchronousFuture<IRouteConfig>(
        NotFoundRouteConfig(),
      );
    }
  }

  @override
  RouteInformation? restoreRouteInformation(IRouteConfig configuration) {
    return RouteInformation(uri: configuration.uri, state: configuration.state);
  }
}
