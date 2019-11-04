import 'package:flutter/material.dart';

///
/// Mr.Liu
///
/// Time:2019-08-06
/// ----------------------
/// description:
///
class MyCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final double width;
  final double height;
  final double elevation;
  final Color shadowColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  const MyCard({
    Key key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.alignment,
    this.color,
    this.elevation: 8.0,
    this.shadowColor: const Color(0xd8d9d9d9),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);

    return Container(
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      padding: padding,
      decoration: BoxDecoration(
          color: color ?? cardTheme.color ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(elevation),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0.0, 2.0),
              blurRadius: elevation,
            ),
          ]),
      child: child,
    );
  }
}
