// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigator_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NavigatorBlocState {
  IRouteConfig get configuration => throw _privateConstructorUsedError;
  List<AppRouteModel> get routesStack => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavigatorBlocStateCopyWith<NavigatorBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigatorBlocStateCopyWith<$Res> {
  factory $NavigatorBlocStateCopyWith(
          NavigatorBlocState value, $Res Function(NavigatorBlocState) then) =
      _$NavigatorBlocStateCopyWithImpl<$Res, NavigatorBlocState>;
  @useResult
  $Res call({IRouteConfig configuration, List<AppRouteModel> routesStack});
}

/// @nodoc
class _$NavigatorBlocStateCopyWithImpl<$Res, $Val extends NavigatorBlocState>
    implements $NavigatorBlocStateCopyWith<$Res> {
  _$NavigatorBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? configuration = null,
    Object? routesStack = null,
  }) {
    return _then(_value.copyWith(
      configuration: null == configuration
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as IRouteConfig,
      routesStack: null == routesStack
          ? _value.routesStack
          : routesStack // ignore: cast_nullable_to_non_nullable
              as List<AppRouteModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavigatorBlocStateImplCopyWith<$Res>
    implements $NavigatorBlocStateCopyWith<$Res> {
  factory _$$NavigatorBlocStateImplCopyWith(_$NavigatorBlocStateImpl value,
          $Res Function(_$NavigatorBlocStateImpl) then) =
      __$$NavigatorBlocStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IRouteConfig configuration, List<AppRouteModel> routesStack});
}

/// @nodoc
class __$$NavigatorBlocStateImplCopyWithImpl<$Res>
    extends _$NavigatorBlocStateCopyWithImpl<$Res, _$NavigatorBlocStateImpl>
    implements _$$NavigatorBlocStateImplCopyWith<$Res> {
  __$$NavigatorBlocStateImplCopyWithImpl(_$NavigatorBlocStateImpl _value,
      $Res Function(_$NavigatorBlocStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? configuration = null,
    Object? routesStack = null,
  }) {
    return _then(_$NavigatorBlocStateImpl(
      configuration: null == configuration
          ? _value.configuration
          : configuration // ignore: cast_nullable_to_non_nullable
              as IRouteConfig,
      routesStack: null == routesStack
          ? _value._routesStack
          : routesStack // ignore: cast_nullable_to_non_nullable
              as List<AppRouteModel>,
    ));
  }
}

/// @nodoc

class _$NavigatorBlocStateImpl implements _NavigatorBlocState {
  const _$NavigatorBlocStateImpl(
      {required this.configuration,
      final List<AppRouteModel> routesStack = const []})
      : _routesStack = routesStack;

  @override
  final IRouteConfig configuration;
  final List<AppRouteModel> _routesStack;
  @override
  @JsonKey()
  List<AppRouteModel> get routesStack {
    if (_routesStack is EqualUnmodifiableListView) return _routesStack;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routesStack);
  }

  @override
  String toString() {
    return 'NavigatorBlocState(configuration: $configuration, routesStack: $routesStack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigatorBlocStateImpl &&
            (identical(other.configuration, configuration) ||
                other.configuration == configuration) &&
            const DeepCollectionEquality()
                .equals(other._routesStack, _routesStack));
  }

  @override
  int get hashCode => Object.hash(runtimeType, configuration,
      const DeepCollectionEquality().hash(_routesStack));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigatorBlocStateImplCopyWith<_$NavigatorBlocStateImpl> get copyWith =>
      __$$NavigatorBlocStateImplCopyWithImpl<_$NavigatorBlocStateImpl>(
          this, _$identity);
}

abstract class _NavigatorBlocState implements NavigatorBlocState {
  const factory _NavigatorBlocState(
      {required final IRouteConfig configuration,
      final List<AppRouteModel> routesStack}) = _$NavigatorBlocStateImpl;

  @override
  IRouteConfig get configuration;
  @override
  List<AppRouteModel> get routesStack;
  @override
  @JsonKey(ignore: true)
  _$$NavigatorBlocStateImplCopyWith<_$NavigatorBlocStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
