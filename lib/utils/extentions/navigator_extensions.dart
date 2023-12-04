import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_bicycle/navigator/bloc/navigator_bloc.dart';

extension FindNavigatorX on BuildContext {
  NavigatorBloc get navBloc => read<NavigatorBloc>();
}
