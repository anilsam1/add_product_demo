

import 'package:add_product_demo/model/product_model.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../ui/add_product_screen.dart';
import '../ui/dashboard_screen.dart';


part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{


  @override

  List<AutoRoute> get routes =>[
    AutoRoute(page: AddProductRoute.page),
    AutoRoute(page: DashBoardRoute.page ,initial: true)

  ];

}