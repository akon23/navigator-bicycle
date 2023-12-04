import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/bloc/navigator_bloc.dart';
import 'package:navigator_bicycle/navigator/routes.dart';
import 'package:navigator_bicycle/utils/extentions/navigator_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('HOME'),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.navBloc.add(
                        NavigatorBlocEvent.push(
                          AppRoutes.settings.withArguments(31313),
                        ),
                      );
                    },
                    child: const Text('SETTINGS'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
