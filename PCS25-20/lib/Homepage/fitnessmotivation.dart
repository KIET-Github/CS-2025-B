import 'package:flutter/material.dart';

class fitnessmotivation extends StatelessWidget {
  const fitnessmotivation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.green.shade400, // #12A7E1
            Color.fromRGBO(91, 82, 82, 0.878), // rgba(0, 0, 0, 0.88)
          ],
          stops: [-20.46 / 100, 115.43 / 100], // Normalize the stops
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20, top: 20, right: 20), // Adjusted padding
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 150,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fitness motivation",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 2.5, // line height = 24px / font size = 1.5
                        letterSpacing: 0.0,
                        //textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "A year from now",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height:
                            1.1875, // line height = 19px / font size = 1.1875
                        letterSpacing: 0.0,
                        //textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "you may wish you ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height:
                            1.1875, // line height = 19px / font size = 1.1875
                        letterSpacing: 0.0,
                        //textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "had started today ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height:
                            1.1875, // line height = 19px / font size = 1.1875
                        letterSpacing: 0.0,
                        //textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  buildCard("assets/images/2.jpg", "Cricket"),
                  buildCard("assets/images/3.jpg", "FootBall"),
                  buildCard("assets/images/4.jpg", "Basket Ball"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String imagePath, String text) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                height: 110,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class Trending_Coach extends StatelessWidget {
//   const Trending_Coach({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [
//             Color(0xFF12A7E1), // #12A7E1
//             Color.fromRGBO(0, 0, 0, 0.88), // rgba(0, 0, 0, 0.88)
//           ],
//           stops: [-20.46 / 100, 115.43 / 100], // Normalize the stops
//         ),
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//               width: 400,
//               height: 150,
//               child:const  Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:  [
//                   Text(
//                     "Trending Coach",
//                     // style: TextStyle(fontWeight: FontWeight.bold),
//                      style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   height: 1.5, // line height = 24px / font size = 1.5
//                   letterSpacing: 0.0,
//                   //textAlign: TextAlign.left,
//                 ),
//                   ),
//                  SizedBox(height: 15),
//                  Text("Get Best Coaches, if",style: TextStyle(
//                   fontFamily: 'Roboto',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   height: 1.1875, // line height = 19px / font size = 1.1875
//                   letterSpacing: 0.0,
//                   //textAlign: TextAlign.left,
//                 ),),
//                   SizedBox(height: 5),
//                   Text("you want to ",
//                   style: TextStyle(
//                   fontFamily: 'Roboto',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   height: 1.1875, // line height = 19px / font size = 1.1875
//                   letterSpacing: 0.0,
//                   //textAlign: TextAlign.left,
//                 ),),
//                   SizedBox(height: 5),
//                   Text("understand this ",style: TextStyle(
//                   fontFamily: 'Roboto',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   height: 1.1875, // line height = 19px / font size = 1.1875
//                   letterSpacing: 0.0,
//                   //textAlign: TextAlign.left,
//                 )),
//                   SizedBox(height: 5),
//                   Text("Game, speak to us!",style: TextStyle(
//                   fontFamily: 'Roboto',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   height: 1.1875, // line height = 19px / font size = 1.1875
//                   letterSpacing: 0.0,
//                   //textAlign: TextAlign.left,
//                 )),
//                 ],
//               ),),
//               //SizedBox(width: 30), // Adjust the width as needed
//               Row(
//                   children: [
//                     buildCard("assets/Cricket3.jpeg", "Cricket"),
//                     buildCard("assets/cricket1.jpeg", "FootBall"),
//                     buildCard("assets/cricket4.jpg", "Basket Ball"),
//                   ],
//                 ),
              
          
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCard(String imagePath, String text) {
//     return Container(
//        margin: EdgeInsets.only(right: 10),
//       child: Column(
//         children: [
//           Card(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.asset(
//                 imagePath,
//                 height: 90,
//                 width: 100,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(height: 6),
//           Align(
            
//             child:Text(text,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
//           ),
//         ],
//       ),
//     );
//   }
// }