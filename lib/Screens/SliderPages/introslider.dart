import 'package:edubridge/Screens/SliderPages/user_type.dart';
import 'package:flutter/material.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  PageController controller = PageController(); //controler for the page

  final messages = ["Connect, collaborate and build a thriving community with our app's community feature .",
   "Streamline your academic path with mentorship-seamless support for a thriving campus experience.",
    "Discover, plan and attend events like never before with our event feature. Whether it's concerts, conferences or local gatherings, our app keeps you informed and connected."];

  final images = [
    'assets/Class Debat 1.png',
    'assets/mentor1.png',
    'assets/College Test Result 1.png',
  ];

  int numberOfPages = 3;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(
                  255, 24, 96, 252),Color.fromARGB(255, 255, 255, 224), Color.fromARGB(255, 209, 232, 247)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top:50),
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: numberOfPages,
                  itemBuilder: (BuildContext context, int index) {
                    return EachPage(messages[index], images[index]);
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(child: Container()),
                        Flexible(
                            child: Indicator(
                              controller: controller, pageCount: 3  ,
                            )
                        ),
                        Flexible(
                          child: (currentPage == numberOfPages - 1)
                              ? GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const UserType())));
                                        },
                                        child: const Text(
                                          "Start",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,color: Colors.black),
                                        )),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    controller.jumpToPage(numberOfPages - 1);
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Skip -->",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EachPage extends StatelessWidget {
  final String message;
  final String image;

  const EachPage(this.message, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 250,
            height: 250,
            child: Image.asset(
              image,
              fit:BoxFit.cover,
            ),
          ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0,120,10,40),
        
              child: Text(message,style: const TextStyle(color: Colors.black87,fontSize: 15),textAlign: TextAlign.center,)
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends AnimatedWidget {
  final PageController controller;
  final int pageCount;
  const Indicator({super.key, required this.controller, required this.pageCount})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: pageCount,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _createIndicator(index);
              }),
        ],
      ),
    );
  }

  Widget _createIndicator(index) {
    double w = 10;
    double h = 10;
    Color color = Colors.black38;
    if (controller.page == index) {
      color = Colors.blue;
      h = 13;
      w = 13;
    }
    return SizedBox(
      height: 26,
      width: 26,
      child: Center(
        child: AnimatedContainer(
          margin: const EdgeInsets.all(5),
          color: color,
          width: w,
          height:h,
          duration: const Duration(microseconds: 0),
        ),
      ),
    );
  }
}
