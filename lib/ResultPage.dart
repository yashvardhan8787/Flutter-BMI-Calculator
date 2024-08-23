import 'package:bmi_calculator/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResultPage extends StatefulWidget {
  final double meterHeight;
  final double weightInkg;
  final double BMI;
  final String result;

  ResultPage(this.meterHeight, this.weightInkg, {super.key})
      : BMI = weightInkg / ((0.30480 * meterHeight )*( 0.30480 * meterHeight)),
        result = (weightInkg / ((0.30480 * meterHeight) * (0.30480 * meterHeight))).toStringAsFixed(2);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with SingleTickerProviderStateMixin {
late AnimationController _controller;
late Animation<double> _animation;
int currentPageIndex = 0;

@override
void initState() {
  super.initState();

  // Initialize the animation controller
  _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  // Define the tween for the animation from 0 to the calculated BMI
  _animation = Tween<double>(begin: 0, end: widget.BMI).animate(_controller)
    ..addListener(() {
      setState(() {
        // Update the UI as the animation progresses
      });
    });

  // Start the animation
  _controller.forward();
}


@override
void dispose() {
  _controller.dispose();
  super.dispose();
} Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Result"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your BMI Result",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 10,
                    maximum: 40,
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: widget.BMI,
                        enableAnimation: true,
                        animationType: AnimationType.easeOutBack,
                        animationDuration: 3000, // Animation duration in milliseconds
                      ),
                    ],
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 10,
                        endValue: 18.5,
                        color: Colors.blue,
                        label: 'Underweight',
                        startWidth: 10,
                        endWidth: 10,
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.blue),
                      ), // Underweight
                      GaugeRange(
                        startValue: 18.5,
                        endValue: 24.9,
                        color: Colors.green,
                        label: 'Normal',
                        startWidth: 10,
                        endWidth: 10,
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.green),
                      ), // Normal
                      GaugeRange(
                        startValue: 25,
                        endValue: 29.9,
                        color: Colors.orange,
                        label: 'Overweight',
                        startWidth: 10,
                        endWidth: 10,
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.orange),
                      ), // Overweight
                      GaugeRange(
                        startValue: 30,
                        endValue: 40,
                        color: Colors.red,
                        label: 'Obese',
                        startWidth: 10,
                        endWidth: 10,
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.red),
                      ), // Obese
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            _animation.value.toStringAsFixed(2), // Display animated BMI value
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(onPressed: ()=>{
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (
                        BuildContext context) => MyHomePage(title: "home page ")
                )
                )
              }, child:Text("Recalculate"),  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
