// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddProductRoute.name: (routeData) {
      final args = routeData.argsAs<AddProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddProductScreen(
          key: args.key,
          fromEdit: args.fromEdit,
          data: args.data,
          index: args.index,
        ),
      );
    },
    DashBoardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashBoardScreen(),
      );
    },
  };
}

/// generated route for
/// [AddProductScreen]
class AddProductRoute extends PageRouteInfo<AddProductRouteArgs> {
  AddProductRoute({
    Key? key,
    required bool fromEdit,
    ProductModel? data,
    int? index,
    List<PageRouteInfo>? children,
  }) : super(
          AddProductRoute.name,
          args: AddProductRouteArgs(
            key: key,
            fromEdit: fromEdit,
            data: data,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'AddProductRoute';

  static const PageInfo<AddProductRouteArgs> page =
      PageInfo<AddProductRouteArgs>(name);
}

class AddProductRouteArgs {
  const AddProductRouteArgs({
    this.key,
    required this.fromEdit,
    this.data,
    this.index,
  });

  final Key? key;

  final bool fromEdit;

  final ProductModel? data;

  final int? index;

  @override
  String toString() {
    return 'AddProductRouteArgs{key: $key, fromEdit: $fromEdit, data: $data, index: $index}';
  }
}

/// generated route for
/// [DashBoardScreen]
class DashBoardRoute extends PageRouteInfo<void> {
  const DashBoardRoute({List<PageRouteInfo>? children})
      : super(
          DashBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
