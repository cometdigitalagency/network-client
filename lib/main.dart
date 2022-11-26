import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_generate_api_client/core/services/retrofit_client/retrofit_client.dart';
import 'package:flutter_generate_api_client/pages/create_page.dart';
import 'package:flutter_generate_api_client/pages/detail_page.dart';
import 'package:flutter_generate_api_client/pages/home_page.dart';
import 'package:logger/logger.dart';

void main() {
  Dio dio = Dio();
  RestClient restClient = RestClient(dio);
  Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: false, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );
  runApp(MyApp(
    logger: logger,
    restClient: restClient,
  ));
}

class MyApp extends StatelessWidget {
  final RestClient restClient;
  final Logger logger;
  const MyApp({super.key, required this.restClient, required this.logger});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Retrofit",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        HomePage.routeName: (context) => HomePage(restClient: restClient),
        CreatePage.routeName: (context) => CreatePage(restClient: restClient),
        DetailPage.routeName: (context) => DetailPage(
              restClient: restClient,
              logger: logger,
            ),
      },
      initialRoute: HomePage.routeName,
    );
  }
}
