import 'package:flutter/material.dart';
import 'package:navigator_bicycle/navigator/bloc/navigator_bloc.dart';
import 'package:navigator_bicycle/navigator/routes.dart';
import 'package:navigator_bicycle/utils/extentions/navigator_extensions.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    required this.args,
    super.key,
  });

  final String args;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      appBar: AppBar(
        title: Text(widget.args),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ABOUT',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            ElevatedButton(
              onPressed: () {
                context.navBloc.add(
                  NavigatorBlocEvent.updateStack(
                    [
                      AppRouteModel(AppRoutes.home.name),
                      AppRouteModel.args(AppRoutes.about.name,
                          arguments: 'New args'),
                    ],
                  ),
                );
              },
              child: const Text('Update stack [home + about]'),
            ),
          ],
        ),
      ),
    );
  }
}
