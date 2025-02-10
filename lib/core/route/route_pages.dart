import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class RoutePages {
  static final ROUTER = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splashPage,
        name: Routes.splashPage,
        builder: (context, state) {
          return Container();
        },
      ),
    ]
  );
}