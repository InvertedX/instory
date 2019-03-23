
import 'package:flutter/widgets.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget widget;

  FadePageRoute({this.widget})
      : super(pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return widget;
  }, transitionsBuilder: ((BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {

     return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
      child: child,
    );
  }));
}