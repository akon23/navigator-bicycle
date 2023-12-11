part of 'navigator_bloc.dart';

@immutable
sealed class NavigatorBlocEvent {
  const factory NavigatorBlocEvent.push(AppRouteModel routeName) = _PushEvent;

  const factory NavigatorBlocEvent.replaceLast(AppRouteModel routeName) =
      _ReplaceLastEvent;

  const factory NavigatorBlocEvent.pop() = _PopEvent;

  const factory NavigatorBlocEvent.updateStack(List<AppRouteModel> stack) =
      _UpdateStackEvent;

  const factory NavigatorBlocEvent.applyConfiguration(
      IRouteConfig configuration) = _ApplyConfigurationEvent;
}

class _PushEvent implements NavigatorBlocEvent {
  const _PushEvent(this.route);

  final AppRouteModel route;
}

class _ReplaceLastEvent implements NavigatorBlocEvent {
  const _ReplaceLastEvent(this.route);

  final AppRouteModel route;
}

class _PopEvent implements NavigatorBlocEvent {
  const _PopEvent();
}

class _UpdateStackEvent implements NavigatorBlocEvent {
  const _UpdateStackEvent(this.stack);

  final List<AppRouteModel> stack;
}

class _ApplyConfigurationEvent implements NavigatorBlocEvent {
  const _ApplyConfigurationEvent(this.configuration);

  final IRouteConfig configuration;
}
