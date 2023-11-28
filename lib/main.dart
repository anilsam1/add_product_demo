import 'dart:io';

import 'package:add_product_demo/model/product_model.dart';
import 'package:add_product_demo/router/app_router.dart';
import 'package:add_product_demo/store/common_store.dart';
import 'package:add_product_demo/ui/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationSupportDirectory();
  print("path ${directory.path}");
  Hive.init(directory.path);
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>('abc');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRoute = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: appRoute.config(),
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}


final commonStore =  Products();