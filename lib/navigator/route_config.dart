import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/routes.dart';

abstract class IRouteConfig implements RouteInformation {
  bool get isRoot;

  IRouteConfig? get previous;

  @override
  Object? get state;

  /// Метод для добавления страницы к текущей конфигурации
  IRouteConfig add(Page page);
}

class BaseRouteConfig extends IRouteConfig {
  BaseRouteConfig({
    required this.uri,
    this.isRoot = false,
  });

  @override
  final Uri uri;

  @override
  final bool isRoot;

  @override
  String get location => uri.path;

  @override
  IRouteConfig? get previous {
    if (location == '/' /*AppRoutes.main*/ ||
        location == AppRoutes.home ||
        location.isEmpty) {
      return null;
    }

    try {
      final pathSegments = uri.pathSegments;
      if (pathSegments.length == 1) {
        return BaseRouteConfig(uri: Uri(path: AppRoutes.home), isRoot: true);
      }

      final newLocation =
          pathSegments.sublist(0, pathSegments.length - 1).join('/');

      return BaseRouteConfig(
        uri: Uri(path: newLocation),
      );
    } on Object {
      return null;
    }
  }

  @override
  Object? get state => {};

  @override
  IRouteConfig add(Page page) {
    if (page.name?.isEmpty ?? true) return this;

    final newUri = Uri(path: '${uri.path}/${page.name}');

    return BaseRouteConfig(uri: newUri);
  }
}

class HomeRouteConfig extends BaseRouteConfig {
  HomeRouteConfig() : super(uri: Uri(path: AppRoutes.home), isRoot: true);
}

class NotFoundRouteConfig extends BaseRouteConfig {
  NotFoundRouteConfig()
      : super(
          uri: Uri(path: AppRoutes.notFound),
          isRoot: false,
        );

  @override
  IRouteConfig? get previous => HomeRouteConfig();
}
