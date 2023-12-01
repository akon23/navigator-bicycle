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

      final configuration = BaseRouteConfig(uri: routeInformation.uri);

      return SynchronousFuture<IRouteConfig>(configuration);
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
