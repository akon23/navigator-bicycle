import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/routes.dart';

typedef PageBuilder = Function(
  BuildContext context,
  List<Page> pages,
);

class PagesBuilder extends StatefulWidget {
  const PagesBuilder({
    super.key,
    required this.builder,
    required this.routes,
    required this.router,
  });

  final PageBuilder builder;
  final List<AppRouteModel> routes;
  final AppRouter router;

  @override
  State<PagesBuilder> createState() => _PagesBuilderState();
}

class _PagesBuilderState extends State<PagesBuilder> {
  List<Page> _pages = [];

  @override
  void initState() {
    super.initState();

    _preparePages();
  }

  @override
  void didUpdateWidget(PagesBuilder oldWidget) {
    if (!const DeepCollectionEquality.unordered()
        .equals(oldWidget.routes, widget.routes)) {
      _preparePages();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _pages,
    );
  }

  void _preparePages() {
    _pages = widget.routes
        .map(
          (route) => MaterialPage(
            child: widget.router.routes[route.name]!.call(context),
            name: route.name,
          ),
        )
        .toList();

    if (_pages.isEmpty) {
      _pages = [
        MaterialPage(
          child: widget.router.routes[AppRoutes.home.name]!.call(context),
          name: AppRoutes.home.name,
        )
      ];
    }
  }
}
