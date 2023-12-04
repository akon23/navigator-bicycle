part of 'navigator_bloc.dart';

@freezed
class NavigatorBlocState with _$NavigatorBlocState {
  const factory NavigatorBlocState({
    required IRouteConfig configuration,
    @Default([]) List<AppRouteModel> routesStack,
  }) = _NavigatorBlocState;
}
