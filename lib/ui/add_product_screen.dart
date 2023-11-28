import 'package:add_product_demo/main.dart';
import 'package:add_product_demo/model/product_model.dart';
import 'package:add_product_demo/ui/neumorphism.dart';
import 'package:add_product_demo/ui/widget/app_button.dart';
import 'package:add_product_demo/value/app_colors.dart';
import 'package:add_product_demo/value/app_strings.dart';
import 'package:add_product_demo/value/app_textstyles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class AddProductScreen extends StatefulWidget {
  final int? index;
  final bool fromEdit;
  final ProductModel? data;

  const AddProductScreen(
      {super.key, required this.fromEdit, this.data, this.index});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int stareRate = 3;

  DateTime today = DateTime.now();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _launchSiteController = TextEditingController();

  @override
  void initState() {
    if (widget.fromEdit) {
      DateTime? formatDate = widget.data?.launchAt;
      String dateSlug =
          "${formatDate?.day.toString().padLeft(2, '0')}-${formatDate?.month.toString().padLeft(2, '0')}-${formatDate?.year.toString()}";
      debugPrint("${widget.index}");
      _productNameController.text = widget.data?.productName ?? "Null";
      _dateController.text = dateSlug;
      _launchSiteController.text = widget.data?.launchSite ?? "Null";
      stareRate = widget.data?.stars ?? 0;
    }
    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _dateController.dispose();
    _launchSiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBG,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 100.h,
        backgroundColor: AppColors.appBG,
        title: widget.fromEdit
            ? Text(
                AppString.stringEditDetails,
                style: productName,
              )
            : Text(
                AppString.stringAddDeatils,
                style: productName,
              ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Column(
              children: [
                35.verticalSpace,
                _commonTextField(
                    suffix: false,
                    fieldEnable: false,
                    hint: AppString.stringProductName,
                    valid: validName,
                    commonController: _productNameController),
                35.verticalSpace,
                ValueListenableBuilder(
                  valueListenable: selectedDate,
                  builder: (context, value, child) {
                    return _commonTextField(
                        suffix: true,
                        fieldEnable: true,
                        hint: AppString.stringLaunchAt,
                        function: selectDate,
                        commonController: _dateController);
                  },
                ),
                35.verticalSpace,
                _commonTextField(
                    suffix: false,
                    fieldEnable: false,
                    hint: AppString.stringLaunchSIte,
                    valid: validName,
                    commonController: _launchSiteController),
                35.verticalSpace,
                Neumorphism(
                    childWidget: SizedBox(
                  width: 1.sw,
                  child: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: Text(
                          AppString.stringRateProduct,
                          style: dateStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0).r,
                        child: RatingBar.builder(
                            initialRating: stareRate.toDouble(),
                            minRating: 1,
                            itemSize: 30.r,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            itemBuilder: (context, _) => Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const ShapeDecoration(
                                    gradient: RadialGradient(
                                      center: Alignment(0.63, 0.20),
                                      radius: 0.65,
                                      colors: [
                                        Color(0xFF89B900),
                                        Color(0xFF1DD4A8)
                                      ],
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
                            onRatingUpdate: (rating) {
                              stareRate = rating.toInt();
                            }),
                      ),
                    ],
                  ),
                )),
                35.verticalSpace,
                Neumorphism(
                    childWidget: Padding(
                  padding: const EdgeInsets.all(8).r,
                  child: AppButton(
                      bgColor: AppColors.appBG,
                      text: !widget.fromEdit
                          ? AppString.stringButtonAddProduct
                          : AppString.stringButtonEditProduct,
                      textColor: AppColors.textColor,
                      arrow: false,
                      function: onAdd),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _commonTextField({
    String? hint,
    required bool suffix,
    FormFieldValidator<String>? valid,
    GestureTapCallback? function,
    required bool fieldEnable,
    TextEditingController? commonController,
  }) {
    return Neumorphism(
        childWidget: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: commonController,
      onTap: function,
      validator: valid,
      readOnly: fieldEnable,
      style: dateStyle,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          hintStyle: dateStyle,
          hintText: hint,
          fillColor: AppColors.appBG,
          suffixIcon: suffix
              ? Icon(
                  Icons.date_range,
                  color: AppColors.textColor,
                )
              : const SizedBox(
                  height: 1,
                  width: 1,
                )),
    ));
  }

  Future<dynamic> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(today.year - 18, today.month, today.day),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black54,
            hintColor: const Color(0xFF8CE7F1),
            colorScheme: const ColorScheme.light(primary: Colors.black54),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null) {
      selectedDate.value = picked;
      String dateSlug =
          "${selectedDate.value.day.toString().padLeft(2, '0')}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.year.toString()}";
      _dateController.text = dateSlug;
      // calAge(picked);
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime(1900)) &&
        day.isBefore(DateTime(today.year - 18, today.month, today.day)))) {
      return true;
    }
    return false;
  }

  String? validName(String? value) {
    if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
      return "Please enter valid details";
    } else {
      return null;
    }
  }

  void onAdd() {
    if (formKey.currentState!.validate()) {
      if (_dateController.text.isNotEmpty) {
        !widget.fromEdit
            ? commonStore.addData(
                ProductModel(
                    productName: _productNameController.text,
                    launchAt: selectedDate.value,
                    launchSite: _launchSiteController.text,
                    stars: stareRate),
                context)
            : commonStore.updateData(
                widget.index,
                ProductModel(
                    productName: _productNameController.text,
                    launchAt: selectedDate.value,
                    launchSite: _launchSiteController.text,
                    stars: stareRate));
        commonStore.sortProductName();
        context.router.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your launch at field is invalid"),
        ));
      }
    }
  }
}
