import 'package:flutter/material.dart';

class Neumorphism extends StatelessWidget {
  final Widget childWidget;

  const Neumorphism({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffefeeee),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffefeeee),
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffefeeee),
              Color(0xffefeeee),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffffffff),
              offset: Offset(-20.0, -20.0),
              blurRadius: 30,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Color(0xffd1d0d0),
              offset: Offset(20.0, 20.0),
              blurRadius: 30,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: childWidget,
      ),
    );
  }
}
