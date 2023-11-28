import 'package:add_product_demo/generated/assets.dart';
import 'package:add_product_demo/main.dart';
import 'package:add_product_demo/router/app_router.dart';
import 'package:add_product_demo/ui/neumorphism.dart';
import 'package:add_product_demo/ui/widget/app_button.dart';
import 'package:add_product_demo/value/app_colors.dart';
import 'package:add_product_demo/value/app_strings.dart';
import 'package:add_product_demo/value/app_textstyles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    commonStore.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: const Icon(Icons.sort_by_alpha),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 100.h,
        backgroundColor: AppColors.appBG,
        title: Text(
          AppString.stringDashboard,
          style: productName,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Neumorphism(
                childWidget: IconButton(
                    onPressed: () {
                      context.router.push(AddProductRoute(fromEdit: false));
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black26,
                    ))),
          )
        ],
      ),
      backgroundColor: AppColors.appBG,
      body: Observer(builder: (context) {
        return commonStore.dataList.isEmpty
            ? Center(child: Lottie.asset(Assets.lottiesAnimation))
            : ListView.builder(
                itemCount: commonStore.dataList.length,
                itemBuilder: (context, index) {
                  return _productItem(index, context);
                },
              );
      }),
    );
  }

  Widget _productItem(int index, BuildContext context) {
    DateTime formatDate = commonStore.dataList[index].launchAt;
    String dateSlug =
        "${formatDate.day.toString().padLeft(2, '0')}-${formatDate.month.toString().padLeft(2, '0')}-${formatDate.year.toString()}";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Neumorphism(
          childWidget: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${commonStore.dataList[index].productName} ".toUpperCase(),
                    style: productName,
                  ),
                ),
                _deleteIconButton(index),
                20.horizontalSpace,
                _editIconButton(context, index),
                8.horizontalSpace
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 20.r,
                  color: AppColors.textColor,
                ),
                6.horizontalSpace,
                Text(
                  "$dateSlug ",
                  style: dateStyle.copyWith(fontSize: 15.sp),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    commonStore.dataList[index].launchSite,
                    style: dateStyle,
                    maxLines: 1,
                  ),
                ),
                const Spacer(),
                _ratingBar(index)
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget _editIconButton(BuildContext context, int index) {
    return Neumorphism(
        childWidget: IconButton(
      color: AppColors.textColor,
      onPressed: () {
        context.router.push(AddProductRoute(
            fromEdit: true, data: commonStore.dataList[index], index: index));
      },
      icon: const Icon(Icons.edit),
    ));
  }

  Widget _deleteIconButton(int index) {
    return Neumorphism(
        childWidget: IconButton(
      color: AppColors.textColor,
      onPressed: () {
        _showAlertBox(index);
      },
      icon: const Icon(Icons.delete),
    ));
  }

  RatingBar _ratingBar(int index) {
    return RatingBar.builder(
        initialRating: commonStore.dataList[index].stars.toDouble(),
        minRating: 1,
        ignoreGestures: true,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemSize: 15,
        itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
        itemBuilder: (context, _) => Container(
              width: 10,
              height: 10,
              decoration: const ShapeDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.63, 0.20),
                  radius: 0.65,
                  colors: [Color(0xFF89B900), Color(0xFF1DD4A8)],
                ),
                shape: StarBorder(
                  points: 5,
                  innerRadiusRatio: 0.5,
                  pointRounding: 0,
                  valleyRounding: 0,
                  rotation: 0,
                  squash: 0,
                ),
              ),
            ),
        onRatingUpdate: (rating) {});
  }

  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.production_quantity_limits),
                title: const Text(AppString.stringSortProduct),
                onTap: () {
                  commonStore.sortProductName();
                  context.router.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text(AppString.stringSortLaunchAt),
                onTap: () {
                  commonStore.sortDate();
                  context.router.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text(AppString.stringSortLaunchSite),
                onTap: () {
                  commonStore.sortLaunchSite();
                  context.router.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text(AppString.stringSortRating),
                onTap: () {
                  commonStore.sortRating();
                  context.router.pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showAlertBox(int index) {
    return showDialog(
      context: context,
      barrierColor: AppColors.appBG,
      builder: (context) => AlertDialog(
        title: const Text(AppString.stringAlertTitle),
        content: const Text(AppString.stringAlertDescription),
        actions: [
          AppButton(
            bgColor: AppColors.appBG,
            text: AppString.stringAlertYes,
            textColor: Colors.red,
            arrow: false,
            function: () {
              commonStore.deleteAt(index);
              context.router.pop();
            },
          ),
          AppButton(
            bgColor: AppColors.appBG,
            text: AppString.stringAlertNo,
            textColor: AppColors.textColor,
            arrow: false,
            function: () {
              context.router.pop();
            },
          )
        ],
      ),
    );
  }
}
