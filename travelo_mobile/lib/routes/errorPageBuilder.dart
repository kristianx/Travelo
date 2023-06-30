import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget errorPageBuilder(BuildContext context, GoRouterState state) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Error'),
    ),
    body: Center(
      child: Text('Error: Page not found.'),
    ),
  );
}
