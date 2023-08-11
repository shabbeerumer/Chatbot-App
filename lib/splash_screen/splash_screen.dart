import 'dart:async';
import 'package:flutter/material.dart';
import '../home_screen/home_screen.dart';
import 'package:lottie/lottie.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  // bool animate = false;

  @override
  void initState() {
    super.initState();
    // Trigger the animation after a delay
    Future.delayed(Duration(seconds: 3), () {
      // setState(() {
      //   animate = true;
      // });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => home_screen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset(
                'lottie/animation_ll5a5naj.json',
                height: mq.height * .40,
              ),
            ),
            Text(
              'Chatbot App',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: mq.width * .10),
            ),
          ],
        ),
        //Stack(
        //   children: [
        //     AnimatedPositioned(
        //       duration: Duration(milliseconds: 50),
        //       right: animate ? mq.width * .25 : -mq.width * .5,
        //       top: mq.height * .17,
        //       child: Center(
        //         child: Image.asset(
        //           'images/chatbot app icon.png',
        //           height: mq.height * .30,
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       top: mq.height * 0.5,
        //       left: mq.width * 0.3,
        //       child: Text(
        //         'Chatbot App',
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'home_screen.dart';
//
// class Splashscreen extends StatefulWidget {
//   const Splashscreen({Key? key}) : super(key: key);
//
//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }
//
// class _SplashscreenState extends State<Splashscreen> {
//   double _imageXPosition = -100.0; // Initial X position
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(seconds: 50), () {
//       setState(() {
//         _imageXPosition = 0.0; // Final X position
//       });
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => HomeScreen()));
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(alignment: Alignment.center, children: [
//               AnimatedPositioned(
//                 duration: Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//                 left: _imageXPosition,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Image.asset(
//                     'images/6873405.png', // Replace with your image asset path
//                     width: 100.0, // Adjust image width as needed
//                     height: 100.0, // Adjust image height as needed
//                   ),
//                 ),
//               ),
//             ]),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               'Chatbot App',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
