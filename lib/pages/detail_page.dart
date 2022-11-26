import 'package:flutter/material.dart';
import 'package:flutter_generate_api_client/core/arguments/detail_arguments.dart';
import 'package:flutter_generate_api_client/core/extensions/string_extension.dart';
import 'package:flutter_generate_api_client/core/models/post_params.dart';
import 'package:flutter_generate_api_client/core/services/retrofit_client/retrofit_client.dart';
import 'package:flutter_generate_api_client/widgets/base_initial_widget.dart';
import 'package:logger/logger.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  const DetailPage({super.key, required this.restClient, required this.logger});
  final RestClient restClient;
  final Logger logger;

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)?.settings.arguments as DetailPageArguments;
    PostParams? postParams;
    return BaseIntialWidget(
      future: restClient.getPost(arg.id),
      builder: (context, data) {
        postParams = data;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Detail Page"),
            actions: [
              if (arg.isEdit)
                TextButton.icon(
                    onPressed: (data != null && postParams != null)
                        ? () async {
                            await restClient
                                .updatePost(data.id.toString(), postParams!)
                                .then((value) {
                              logger.i(value);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Title: \n${value.title}\n\nBody:\n${value.body}")));
                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              logger.e("Cannot update the post",
                                  [error, stackTrace]);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Cannot update this post')));
                              Navigator.pop(context);
                            });
                          }
                        : null,
                    icon: const Icon(Icons.save_outlined, color: Colors.white),
                    label: const Text("")),
              if (!arg.isEdit)
                TextButton.icon(
                    onPressed: data != null
                        ? () {
                            Navigator.pushNamed(
                              context,
                              DetailPage.routeName,
                              arguments:
                                  DetailPageArguments(data.id.toString(), true),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text("")),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    color: Colors.blue.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width),
                        child: arg.isEdit
                            ? TextField(
                                controller: TextEditingController(
                                  text: data!.title.defaultString,
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                minLines: 1,
                                maxLines: 100,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Title',
                                ),
                                onChanged: (title) {
                                  postParams =
                                      PostParams(data.userId, title, data.body);
                                },
                              )
                            : Text(
                                data!.title.defaultString,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                      margin: EdgeInsets.zero,
                      color: Colors.blue.shade100,
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        constraints: const BoxConstraints(minHeight: 300),
                        child: arg.isEdit
                            ? TextField(
                                controller: TextEditingController(
                                  text: data.body.defaultString,
                                ),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 2),
                                minLines: 1,
                                maxLines: 100,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Body',
                                ),
                                onChanged: (body) {
                                  postParams =
                                      PostParams(data.userId, data.title, body);
                                },
                              )
                            : Text(
                                data.body.defaultString,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 2),
                              ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
