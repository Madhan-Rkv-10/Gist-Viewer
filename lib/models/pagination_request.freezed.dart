// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaginationRequest _$PaginationRequestFromJson(Map<String, dynamic> json) {
  return _PaginationRequest.fromJson(json);
}

/// @nodoc
mixin _$PaginationRequest {
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationRequestCopyWith<PaginationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationRequestCopyWith<$Res> {
  factory $PaginationRequestCopyWith(
          PaginationRequest value, $Res Function(PaginationRequest) then) =
      _$PaginationRequestCopyWithImpl<$Res, PaginationRequest>;
  @useResult
  $Res call({int page, int perPage});
}

/// @nodoc
class _$PaginationRequestCopyWithImpl<$Res, $Val extends PaginationRequest>
    implements $PaginationRequestCopyWith<$Res> {
  _$PaginationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationRequestImplCopyWith<$Res>
    implements $PaginationRequestCopyWith<$Res> {
  factory _$$PaginationRequestImplCopyWith(_$PaginationRequestImpl value,
          $Res Function(_$PaginationRequestImpl) then) =
      __$$PaginationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int perPage});
}

/// @nodoc
class __$$PaginationRequestImplCopyWithImpl<$Res>
    extends _$PaginationRequestCopyWithImpl<$Res, _$PaginationRequestImpl>
    implements _$$PaginationRequestImplCopyWith<$Res> {
  __$$PaginationRequestImplCopyWithImpl(_$PaginationRequestImpl _value,
      $Res Function(_$PaginationRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(_$PaginationRequestImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationRequestImpl implements _PaginationRequest {
  const _$PaginationRequestImpl({required this.page, required this.perPage});

  factory _$PaginationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationRequestImplFromJson(json);

  @override
  final int page;
  @override
  final int perPage;

  @override
  String toString() {
    return 'PaginationRequest(page: $page, perPage: $perPage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationRequestImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page, perPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationRequestImplCopyWith<_$PaginationRequestImpl> get copyWith =>
      __$$PaginationRequestImplCopyWithImpl<_$PaginationRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationRequestImplToJson(
      this,
    );
  }
}

abstract class _PaginationRequest implements PaginationRequest {
  const factory _PaginationRequest(
      {required final int page,
      required final int perPage}) = _$PaginationRequestImpl;

  factory _PaginationRequest.fromJson(Map<String, dynamic> json) =
      _$PaginationRequestImpl.fromJson;

  @override
  int get page;
  @override
  int get perPage;
  @override
  @JsonKey(ignore: true)
  _$$PaginationRequestImplCopyWith<_$PaginationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
