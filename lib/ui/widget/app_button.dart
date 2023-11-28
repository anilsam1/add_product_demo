import 'package:add_product_demo/value/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppButton extends StatefulWidget {
  final Color bgColor;
  final Color textColor;
  final bool arrow;
  final String text;
  final VoidCallback? function;

  const AppButton(
      {super.key,
      required this.bgColor,
      required this.text,
      required this.textColor,
      required this.arrow,
      this.function});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        style: ElevatedButton.styleFrom(
          elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15).r,
            ),
           backgroundColor:  widget.bgColor ),

        onPressed: widget.function ?? (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: dateStyle.copyWith(color: widget.textColor, fontSize: 16.sp),
            ),
            8.w.horizontalSpace,
            widget.arrow
                ? const Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  )
                : Container()
          ],
        ));
  }
}
