// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClothItemCompoundViewSettings {
  ClothItemCompoundViewLayout get layout => throw _privateConstructorUsedError;
  ClothItemSortMode get sortMode => throw _privateConstructorUsedError;
  Set<ClothItemAttribute> get filteredAttributes =>
      throw _privateConstructorUsedError;
  Set<ClothItemType> get filteredTypes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClothItemCompoundViewSettingsCopyWith<ClothItemCompoundViewSettings>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClothItemCompoundViewSettingsCopyWith<$Res> {
  factory $ClothItemCompoundViewSettingsCopyWith(
          ClothItemCompoundViewSettings value,
          $Res Function(ClothItemCompoundViewSettings) then) =
      _$ClothItemCompoundViewSettingsCopyWithImpl<$Res,
          ClothItemCompoundViewSettings>;
  @useResult
  $Res call(
      {ClothItemCompoundViewLayout layout,
      ClothItemSortMode sortMode,
      Set<ClothItemAttribute> filteredAttributes,
      Set<ClothItemType> filteredTypes});
}

/// @nodoc
class _$ClothItemCompoundViewSettingsCopyWithImpl<$Res,
        $Val extends ClothItemCompoundViewSettings>
    implements $ClothItemCompoundViewSettingsCopyWith<$Res> {
  _$ClothItemCompoundViewSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layout = null,
    Object? sortMode = null,
    Object? filteredAttributes = null,
    Object? filteredTypes = null,
  }) {
    return _then(_value.copyWith(
      layout: null == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as ClothItemCompoundViewLayout,
      sortMode: null == sortMode
          ? _value.sortMode
          : sortMode // ignore: cast_nullable_to_non_nullable
              as ClothItemSortMode,
      filteredAttributes: null == filteredAttributes
          ? _value.filteredAttributes
          : filteredAttributes // ignore: cast_nullable_to_non_nullable
              as Set<ClothItemAttribute>,
      filteredTypes: null == filteredTypes
          ? _value.filteredTypes
          : filteredTypes // ignore: cast_nullable_to_non_nullable
              as Set<ClothItemType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClothItemCompoundViewSettingsImplCopyWith<$Res>
    implements $ClothItemCompoundViewSettingsCopyWith<$Res> {
  factory _$$ClothItemCompoundViewSettingsImplCopyWith(
          _$ClothItemCompoundViewSettingsImpl value,
          $Res Function(_$ClothItemCompoundViewSettingsImpl) then) =
      __$$ClothItemCompoundViewSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ClothItemCompoundViewLayout layout,
      ClothItemSortMode sortMode,
      Set<ClothItemAttribute> filteredAttributes,
      Set<ClothItemType> filteredTypes});
}

/// @nodoc
class __$$ClothItemCompoundViewSettingsImplCopyWithImpl<$Res>
    extends _$ClothItemCompoundViewSettingsCopyWithImpl<$Res,
        _$ClothItemCompoundViewSettingsImpl>
    implements _$$ClothItemCompoundViewSettingsImplCopyWith<$Res> {
  __$$ClothItemCompoundViewSettingsImplCopyWithImpl(
      _$ClothItemCompoundViewSettingsImpl _value,
      $Res Function(_$ClothItemCompoundViewSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layout = null,
    Object? sortMode = null,
    Object? filteredAttributes = null,
    Object? filteredTypes = null,
  }) {
    return _then(_$ClothItemCompoundViewSettingsImpl(
      layout: null == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as ClothItemCompoundViewLayout,
      sortMode: null == sortMode
          ? _value.sortMode
          : sortMode // ignore: cast_nullable_to_non_nullable
              as ClothItemSortMode,
      filteredAttributes: null == filteredAttributes
          ? _value._filteredAttributes
          : filteredAttributes // ignore: cast_nullable_to_non_nullable
              as Set<ClothItemAttribute>,
      filteredTypes: null == filteredTypes
          ? _value._filteredTypes
          : filteredTypes // ignore: cast_nullable_to_non_nullable
              as Set<ClothItemType>,
    ));
  }
}

/// @nodoc

class _$ClothItemCompoundViewSettingsImpl
    implements _ClothItemCompoundViewSettings {
  const _$ClothItemCompoundViewSettingsImpl(
      {this.layout = ClothItemCompoundViewLayout.grid,
      this.sortMode = ClothItemSortMode.byName,
      final Set<ClothItemAttribute> filteredAttributes = const {},
      final Set<ClothItemType> filteredTypes = const {}})
      : _filteredAttributes = filteredAttributes,
        _filteredTypes = filteredTypes;

  @override
  @JsonKey()
  final ClothItemCompoundViewLayout layout;
  @override
  @JsonKey()
  final ClothItemSortMode sortMode;
  final Set<ClothItemAttribute> _filteredAttributes;
  @override
  @JsonKey()
  Set<ClothItemAttribute> get filteredAttributes {
    if (_filteredAttributes is EqualUnmodifiableSetView)
      return _filteredAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_filteredAttributes);
  }

  final Set<ClothItemType> _filteredTypes;
  @override
  @JsonKey()
  Set<ClothItemType> get filteredTypes {
    if (_filteredTypes is EqualUnmodifiableSetView) return _filteredTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_filteredTypes);
  }

  @override
  String toString() {
    return 'ClothItemCompoundViewSettings(layout: $layout, sortMode: $sortMode, filteredAttributes: $filteredAttributes, filteredTypes: $filteredTypes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClothItemCompoundViewSettingsImpl &&
            (identical(other.layout, layout) || other.layout == layout) &&
            (identical(other.sortMode, sortMode) ||
                other.sortMode == sortMode) &&
            const DeepCollectionEquality()
                .equals(other._filteredAttributes, _filteredAttributes) &&
            const DeepCollectionEquality()
                .equals(other._filteredTypes, _filteredTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      layout,
      sortMode,
      const DeepCollectionEquality().hash(_filteredAttributes),
      const DeepCollectionEquality().hash(_filteredTypes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClothItemCompoundViewSettingsImplCopyWith<
          _$ClothItemCompoundViewSettingsImpl>
      get copyWith => __$$ClothItemCompoundViewSettingsImplCopyWithImpl<
          _$ClothItemCompoundViewSettingsImpl>(this, _$identity);
}

abstract class _ClothItemCompoundViewSettings
    implements ClothItemCompoundViewSettings {
  const factory _ClothItemCompoundViewSettings(
          {final ClothItemCompoundViewLayout layout,
          final ClothItemSortMode sortMode,
          final Set<ClothItemAttribute> filteredAttributes,
          final Set<ClothItemType> filteredTypes}) =
      _$ClothItemCompoundViewSettingsImpl;

  @override
  ClothItemCompoundViewLayout get layout;
  @override
  ClothItemSortMode get sortMode;
  @override
  Set<ClothItemAttribute> get filteredAttributes;
  @override
  Set<ClothItemType> get filteredTypes;
  @override
  @JsonKey(ignore: true)
  _$$ClothItemCompoundViewSettingsImplCopyWith<
          _$ClothItemCompoundViewSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
