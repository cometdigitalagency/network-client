import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseIntialWidget<T> extends StatelessWidget {
  const BaseIntialWidget({super.key, this.future, required this.builder});
  final Future<T>? future;
  final Widget Function(BuildContext context, T? data) builder;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (ctx, snapshot) {
        // Checking if future is resolved or not
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            String? errorMessage;
            if (snapshot.error.runtimeType is DioError) {
              DioError error = snapshot.error as DioError;
              errorMessage = error.message;
            } else {
              errorMessage = snapshot.error.toString();
            }
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(fontSize: 18),
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            return builder(ctx, snapshot.data);
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return Center(
          child: Platform.isAndroid
              ? const CircularProgressIndicator()
              : const CupertinoActivityIndicator(),
        );
      },
    );
  }
}
