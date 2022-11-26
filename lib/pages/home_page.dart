import 'package:flutter/material.dart';
import 'package:flutter_generate_api_client/core/arguments/detail_arguments.dart';
import 'package:flutter_generate_api_client/core/models/post.dart';
import 'package:flutter_generate_api_client/core/services/retrofit_client/retrofit_client.dart';
import 'package:flutter_generate_api_client/pages/create_page.dart';
import 'package:flutter_generate_api_client/pages/detail_page.dart';
import 'package:flutter_generate_api_client/widgets/base_initial_widget.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  final RestClient restClient;
  const HomePage({
    super.key,
    required this.restClient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: BaseIntialWidget<List<Post>>(
        future: restClient.getPosts(),
        builder: (context, data) {
          // Extracting data from snapshot object
          List<Post> posts = data ?? [];
          return ListView.separated(
            itemCount: posts.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) {
              Post? post = posts[index];
              return ListTile(
                title: Text(post.title),
                onTap: () {
                  Navigator.pushNamed(context, DetailPage.routeName,
                      arguments:
                          DetailPageArguments(post.id.toString(), false));
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreatePage.routeName);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
