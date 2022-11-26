import 'package:dio/dio.dart';
import 'package:flutter_generate_api_client/core/constants/api.dart';
import 'package:flutter_generate_api_client/core/models/post.dart';
import 'package:flutter_generate_api_client/core/models/post_params.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: Api.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(Api.postsPath)
  Future<List<Post>> getPosts();

  @GET(Api.postsPath)
  Future<List<Post>> searchPosts({
    @Query(Api.bodyQuery) String? body,
    @Query(Api.titleQuery) String? title,
    @Query(Api.idQuery) int? id,
    @Query(Api.userIdQuery) int? userId,
  });

  @GET(Api.postPath)
  Future<Post> getPost(@Path(Api.idPath) String id);

  @POST(Api.postsPath)
  Future<Post> createPost(@Body() PostParams body);

  @PUT(Api.postPath)
  Future<Post> updatePost(@Path(Api.idPath) String id, @Body() PostParams body);

  @DELETE(Api.postPath)
  Future<dynamic> deletePost(@Path(Api.idPath) String id);
}
