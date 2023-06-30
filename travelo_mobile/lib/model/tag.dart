import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  int? id;
  String? name;

  Tag();

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
