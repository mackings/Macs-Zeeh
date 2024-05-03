import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Uses the [Fluttertoast] package
///to build a custom Toast widget
///according to design specification.
class AppSnackbar {
  final BuildContext context;
  final bool isError;
  final int? seconds;

  final FToast _fToast = FToast();

  AppSnackbar(
    this.context, {
    this.isError = false,
    this.seconds,
  }) {
    _fToast.init(context);
  }
  void showToast({required String text}) {
    final Size size = MediaQuery.of(context).size;
    final Widget toastWidget = Container(
      width: size.width * 0.8744,
      padding: const EdgeInsets.fromLTRB(24.0, 14.0, 24.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: isError
            ? const Color.fromARGB(228, 241, 182, 182)
            : const Color(0xDDB7F1B6),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: isError
                ? const Color.fromARGB(255, 161, 77, 77)
                : const Color(0xff4EA14D),
            fontSize: 16.0),
      ),
    );

    _fToast.showToast(
      child: toastWidget,
      toastDuration: Duration(seconds: seconds ?? 3),
      gravity: ToastGravity.TOP,
      positionedToastBuilder: (context, child) => Positioned(
        top: size.height * 0.0725,
        left: size.width * 0.0628,
        child: Center(child: child),
      ),
    );
  }
}
