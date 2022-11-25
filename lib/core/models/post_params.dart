import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_params.g.dart';

@JsonSerializable()
class PostParams extends Equatable {
  final int userId;
  final String title;
  final String body;

  const PostParams(this.userId, this.title, this.body);

  factory PostParams.fromJson(Map<String, dynamic> json) =>
      _$PostParamsFromJson(json);
  Map<String, dynamic> toJson() => _$PostParamsToJson(this);

  @override
  List<Object?> get props => [userId, title, body];
}
