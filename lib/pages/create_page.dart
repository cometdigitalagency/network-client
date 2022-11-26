import 'package:flutter/material.dart';
import 'package:flutter_generate_api_client/core/models/post_params.dart';
import 'package:flutter_generate_api_client/core/services/retrofit_client/retrofit_client.dart';

class CreatePage extends StatelessWidget {
  static const routeName = '/create';
  const CreatePage({super.key, required this.restClient});
  final RestClient restClient;

  @override
  Widget build(BuildContext context) {
    int userId = 0;
    String title = "";
    String body = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Page"),
        actions: [
          TextButton.icon(
              onPressed: () async {
                await restClient
                    .createPost(PostParams(userId, title, body))
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "UserId:\n${value.userId}\n\nTitle:\n${value.title}\n\nBody:\n${value.body}")));
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cannot create the post')));
                  Navigator.pop(context);
                });
              },
              icon: const Icon(Icons.save_outlined, color: Colors.white),
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
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        minLines: 1,
                        maxLines: 100,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'User ID',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (data) {
                          userId = int.parse(data);
                        },
                      )),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                margin: EdgeInsets.zero,
                elevation: 5,
                color: Colors.blue.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width),
                      child: TextField(
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
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (data) {
                          title = data;
                        },
                      )),
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
                  child: TextField(
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
                    onChanged: (data) {
                      body = data;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
