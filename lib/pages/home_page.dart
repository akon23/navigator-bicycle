import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/bloc/navigator_bloc.dart';
import 'package:navigator_bicycle/navigator/routes.dart';
import 'package:navigator_bicycle/utils/extentions/navigator_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade700,
      appBar: AppBar(
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
          const SizedBox(height: 50),
          const Text('HOME'),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.navBloc.add(
                    NavigatorBlocEvent.push(
                      AppRoutes.settings.withArguments(313131),
                    ),
                  );
                },
                child: const Text('SETTINGS'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.navBloc.add(
                    NavigatorBlocEvent.push(
                      AppRoutes.tabsPage.withArguments(1),
                    ),
                  );
                },
                child: const Text('TABS'),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Expanded(
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
    );
  }
}
