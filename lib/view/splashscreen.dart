import 'dart:async';
import 'package:covid19_case_tracker/view/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with TickerProviderStateMixin {


      
  late final AnimationController animationController =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

 
void dispose() {
    animationController.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push((context),
          MaterialPageRoute(builder: (context) => WorldStateScreen())),
    );
  }
   

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: animationController,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                      child: Image(image: AssetImage('images/virus.png'))),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: animationController.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Covid-19 Case \nTracker App', textAlign: TextAlign.center,
                style: TextStyle(
                  
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  //color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
