import 'package:flutter/material.dart';
import 'package:new_toast/constant/app_images.dart';
import '../alert/alertDialgue.dart';
// import '../circletoast/view/widget/custom_widget.dart';

class ExampleToastScreen extends StatelessWidget {
  const ExampleToastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Center(
          child: Center(
        child: CustomMessageAlert(
          message: "Not Internet",
          backgroundColor: Colors.white,
          textStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
          image: Image.asset(browser),
          radius: 15.0,
          imageWidth: 50,
          shadowColor: Colors.blue,
          shadowOpacity: 0.5,
        ),
      )
          // ElevatedButton(
          //   onPressed: () {
          //     CircularToast.show(
          //       context,
          //       useAnimation: false,
          //       message: 'Countdown',
          //       countdownSeconds: 10,
          //       backgroundColor: const Color.fromARGB(255, 217, 215, 215),
          //       textColor: Colors.blue,
          //       radius: 60.0,
          //       height: 70.0,
          //       width: 90.0,

          //       textStyle: const TextStyle(
          //         color: Colors.black,
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     );

          //     // CustomToast.show(
          //     //   context,
          //     //   backgroundColor: Colors.white,
          //     //   shadhowColor: Colors.green.withOpacity(0.5),
          //     //   image: Image.asset(mark),
          //     //   message: "This is a custom toast message",
          //     //   textStyle: const TextStyle(color: Colors.black),
          //     //   position: ToastPosition.top,
          //     // );
          //   },
          //   child: const Text("Show Toast"),
          // ),
          ),
    );
  }
}
