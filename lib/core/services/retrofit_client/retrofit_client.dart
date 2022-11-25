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
    @Query("body") String? body,
    @Query("title") String? title,
    @Query("id") int? id,
    @Query("userId") int? userId,
  });

  @GET(Api.postPath)
  Future<Post> getPost(@Path("id") String id);

  @POST(Api.postsPath)
  Future<Post> createPost(@Body() PostParams body);

  @PUT(Api.postPath)
  Future<Post> updatePost(@Path("id") String id, @Body() Post body);

  @DELETE(Api.postPath)
  Future<dynamic> deletePost(@Path("id") String id);
}
