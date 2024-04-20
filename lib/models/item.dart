import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part "item.g.dart";
part "item.freezed.dart";

@freezed
class Item with _$Item {
  // final String id;
  // final String name;
  const factory Item({required String id, required String name}) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  // Map<String, dynamic> toJson() => _$ItemToJson(this);
}
