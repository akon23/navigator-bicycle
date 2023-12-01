import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/route_config.dart';
import 'package:navigator_bicycle/navigator/routes.dart';

typedef PageBuilder = Function(
  BuildContext context,
  List<Page> pages,
);

class PagesBuilder extends StatefulWidget {
  const PagesBuilder({
    super.key,
    required AppRouter router,
    required this.configuration,
    required this.builder,
  }) : _router = router;

  final IRouteConfig configuration;
  final PageBuilder builder;
  final AppRouter _router;

  @override
  State<PagesBuilder> createState() => _PagesBuilderState();
}

class _PagesBuilderState extends State<PagesBuilder> {
  late IRouteConfig _configuration;
  List<Page> _pages = [];

  @override
  void initState() {
    super.initState();
    _preparePages();
  }

  @override
  void didUpdateWidget(PagesBuilder oldWidget) {
    if (_configuration.uri != widget.configuration.uri) {
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
    _configuration = widget.configuration;

    final pagesNames = widget.configuration.uri.pathSegments;
    _pages = pagesNames
        .where((name) => widget._router.routes.containsKey(name))
        .map(
          (name) => MaterialPage(
            child: widget._router.routes[name]!.call(context),
          ),
        )
        .toList();

    if (_pages.isEmpty) {
      _pages = [
        MaterialPage(
          child: widget._router.routes[AppRoutes.home]!.call(context),
          name: AppRoutes.home,
        )
      ];
    }
  }
}
