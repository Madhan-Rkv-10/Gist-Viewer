import 'package:freezed_annotation/freezed_annotation.dart';
part "pagination_request.g.dart";
part "pagination_request.freezed.dart";

@freezed
class PaginationRequest with _$PaginationRequest {
  const factory PaginationRequest({
    required int page,
    required int perPage,
  }) = _PaginationRequest;

  factory PaginationRequest.fromJson(Map<String, dynamic> json) =>
      _$PaginationRequestFromJson(json);
}
