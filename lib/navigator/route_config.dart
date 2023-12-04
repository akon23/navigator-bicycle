import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/routes.dart';

@immutable
abstract class IRouteConfig implements RouteInformation {
  const IRouteConfig();

  bool get isRoot;

  IRouteConfig? get previous;

  @override
  Map<String, Object?>? get state;

  /// Метод для добавления страницы к текущей конфигурации
  IRouteConfig add(AppRouteModel page);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IRouteConfig &&
          uri.path == other.uri.path &&
          isRoot == other.isRoot &&
          const DeepCollectionEquality.unordered().equals(
            state,
            other.state,
          ));

  @override
  int get hashCode => Object.hash(isRoot, uri.path, state);
}

class BaseRouteConfig extends IRouteConfig {
  const BaseRouteConfig({
    required this.uri,
    this.isRoot = false,
    this.state,
  });

  @override
  final Uri uri;

  @override
  final bool isRoot;

  @override
  final Map<String, Object?>? state;

  @override
  String get location => uri.path;

  @override
  IRouteConfig? get previous {
    if (location == AppRoutes.main.name ||
        location == AppRoutes.home.name ||
        location.isEmpty) {
      return null;
    }

    try {
      final pathSegments = uri.pathSegments;
      if (pathSegments.length == 1) {
        return HomeRouteConfig();
      }

      final newLocation =
          pathSegments.sublist(0, pathSegments.length - 1).join('/');

      final newState = state;
      if (newState != null) {
        newState.remove(pathSegments.last);
      }

      return BaseRouteConfig(
        uri: Uri(path: newLocation),
        state: newState,
      );
    } on Object {
      return null;
    }
  }

  @override
  IRouteConfig add(AppRouteModel page) {
    if (page.name.isEmpty) return this;

    final newUri = Uri(path: '${uri.path}/${page.name}');

    final args = page.arguments;

    if (args is Map<String, Object?> || state != null) {
      return BaseRouteConfig(
        uri: newUri,
        state: <String, Object?>{
          ...?state,
          if (args is Object) page.name: args,
        },
      );
    }

    return BaseRouteConfig(uri: newUri);
  }
}

class HomeRouteConfig extends BaseRouteConfig {
  HomeRouteConfig() : super(uri: Uri(path: AppRoutes.home.name), isRoot: true);

  @override
  Map<String, Object?>? get state => <String, Object?>{};
}

class NotFoundRouteConfig extends BaseRouteConfig {
  NotFoundRouteConfig()
      : super(
          uri: Uri(path: AppRoutes.notFound.name),
          isRoot: false,
        );

  @override
  IRouteConfig? get previous => HomeRouteConfig();

  @override
  Map<String, Object?>? get state => <String, Object?>{};
}
