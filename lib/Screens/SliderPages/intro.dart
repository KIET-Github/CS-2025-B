import 'package:edubridge/Screens/SliderPages/introslider.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HalfCircleBackground(),
    );
  }
}

class HalfCircleBackground extends StatelessWidget {
  const HalfCircleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.white, // Bottom half color
          ),
        ),
        Positioned.fill(
          child: ClipPath(
            clipper: TopHalfCircleClipper(),
            child: Container(
              color: const Color.fromARGB(
                  255, 24, 96, 252), // Top half color and circle color
            ),
          ),
        ),
         Positioned(
          top: 180, // Adjust the top position as needed
          left: 20, // Adjust the left position as needed
          right: 20, // Adjust the right position as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 400,
                child: Image(image: AssetImage('assets/edu.png'))
                ),
              const Text(
                "One  Campus  One  Portal ", // Your text here
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 18, // Font size
                  fontWeight: FontWeight.bold, // Font weight
                ),
                textAlign: TextAlign.center, // Center align the text
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: 150, // Adjust the top position as needed
          left: 20, // Adjust the left position as needed
          right: 20, //
          child: Text(
            "WELCOME", // Your text here
            style: TextStyle(
              color: Colors.black, // Text color
              fontSize: 50, // Font size
              fontWeight: FontWeight.bold, // Font weight
            ),
            textAlign: TextAlign.center, // Center align the text
          ),
        ),
        Positioned(
          bottom: 80, // Adjust the top position as needed
          left: 20, // Adjust the left position as needed
          right: 20, //
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IntroSlider()),
              );
            },
            child: const Text(
              "Get started", // Your text here
              style: TextStyle(
                color: Colors.black, // Text color
                fontSize: 20, // Font size
                fontWeight: FontWeight.bold, // Font weight
              ),
              textAlign: TextAlign.center, // Center align the text
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              // decoration: BoxDecoration(borderRadius:BorderRadius.circular(10) ),
              width: MediaQuery.of(context).size.width * 0.2, // 80% of the screen width
              height:  MediaQuery.of(context).devicePixelRatio*2 , // 3 cm height
              color: Colors.black, // Black border color
            ),
          ),
        ),
      ],
    );
  }
}

class TopHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double offset = 100.0;
    double radiusFactor = 0.85; // Adjusted value to decrease the radius

    path.moveTo(0, size.height * 0.5 - offset);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * radiusFactor, // Control the height of the curve
      size.width,
      size.height * 0.5 - offset,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
