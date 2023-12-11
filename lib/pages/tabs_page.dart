import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/bloc/navigator_bloc.dart';
import 'package:navigator_bicycle/navigator/routes.dart';
import 'package:navigator_bicycle/utils/extentions/navigator_extensions.dart';
import 'package:navigator_bicycle/widgets/bottom_navigation_item.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({
    super.key,
    required this.tabIndex,
  });

  final int tabIndex;

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: widget.tabIndex,
      length: 2,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(TabsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tabIndex != widget.tabIndex) {
      _tabController.animateTo(widget.tabIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade700,
      appBar: AppBar(
        title: Text('Tabs ${_tabController.index + 1}'),
        actions: [
          IconButton(
            onPressed: () {
              context.navBloc.add(const NavigatorBlocEvent.pop());
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO: child
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    _TabOnePage(index: 1, name: 'Home'),
                    _TabTwoPage(index: 2, name: 'Settings'),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black26, width: 2),
              ),
            ),
            constraints: const BoxConstraints(maxHeight: 100),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavigationItem(
                    title: 'Home',
                    icon: Icons.home,
                    isActive: _tabController.index == 0,
                    onItemSelected: () {
                      context.navBloc.add(
                        NavigatorBlocEvent.replaceLast(
                          AppRoutes.tabsPage.withArguments(0),
                        ),
                      );
                    },
                  ),
                  BottomNavigationItem(
                    title: 'Settings',
                    icon: Icons.settings,
                    isActive: _tabController.index == 1,
                    onItemSelected: () {
                      context.navBloc.add(
                        NavigatorBlocEvent.replaceLast(
                          AppRoutes.tabsPage.withArguments(1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabOnePage extends StatelessWidget {
  const _TabOnePage({required this.index, required this.name});

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Tab page $index\n($name)',
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.navBloc.add(
                  NavigatorBlocEvent.replaceLast(
                    AppRoutes.tabsPage.withArguments(1),
                  ),
                );

                /*final stack = context.navBloc.state.routesStack.toList();
                stack.removeLast();

                final newStack = [
                  ...stack,
                  AppRoutes.tabsPage.withArguments(1),
                ];

                context.navBloc.add(
                  NavigatorBlocEvent.updateStack(newStack),
                );*/
              },
              child: const Text('Go to tab 2'),
            ),
            Expanded(
              flex: 2,
              child: ColoredBox(
                color: Colors.white54,
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    title: Text('Item $index'),
                    onTap: () {
                      context.navBloc.add(
                        NavigatorBlocEvent.push(
                          AppRoutes.about.withArguments('About args $index'),
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabTwoPage extends StatelessWidget {
  const _TabTwoPage({required this.index, required this.name});

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Tab page $index\n($name)',
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.navBloc.add(
                  NavigatorBlocEvent.replaceLast(
                    AppRoutes.tabsPage.withArguments(0),
                  ),
                );

                // final stack = context.navBloc.state.routesStack.toList();
                // stack.removeLast();
                //
                // final newStack = [
                //   ...stack,
                //   AppRoutes.tabsPage.withArguments(0),
                // ];
                //
                // context.navBloc.add(
                //   NavigatorBlocEvent.updateStack(newStack),
                // );
              },
              child: const Text('Go to tab 1'),
            ),
          ],
        ),
      ),
    );
  }
}
