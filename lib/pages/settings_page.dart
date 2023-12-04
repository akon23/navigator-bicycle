import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/bloc/navigator_bloc.dart';
import 'package:navigator_bicycle/navigator/routes.dart';
import 'package:navigator_bicycle/utils/extentions/navigator_extensions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.args});

  final int args;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
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
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('SETTINGS'),
              const SizedBox(height: 20),
              Text('ARGS : ${widget.args}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.navBloc.add(
                    NavigatorBlocEvent.push(
                      AppRoutes.about.withArguments('ABOUT page args'),
                    ),
                  );
                },
                child: const Text('ABOUT'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
