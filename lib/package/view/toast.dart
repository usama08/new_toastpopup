import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_toast/package/new_toast.dart';
import '../../constant/svg.dart';

class ExampleToastScreen extends StatelessWidget {
  const ExampleToastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toast Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            CustomToast.show(
              context,
              backgroundColor: Colors.white,
              shadhowColor: Colors.green.withOpacity(0.5),
              image: SvgPicture.asset(pdf),
              message: "This is a custom toast message",
              textStyle: const TextStyle(color: Colors.black),
              position: ToastPosition.right,
            );
          },
          child: const Text("Show Toast"),
        ),
      ),
    );
  }
}
