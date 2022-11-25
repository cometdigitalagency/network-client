import 'package:flutter_generate_api_client/core/models/post_params.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post extends PostParams {
  final int id;

  const Post(this.id, int userId, String title, String body)
      : super(userId, title, body);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [id, userId, title, body];
}
