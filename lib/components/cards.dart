
  import 'package:flutter/material.dart';
 

 Widget buildClubCard(String imagePath, String title, String department) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 110,
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(imagePath),
              ),
            ),
            Text(title),
            Text(
              department,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
            Container(
              width: 80,
              height: 18,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 33, 103, 243),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  "Apply Now",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


 Widget buildMentorCard(String imagePath, String title, String department) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 200,
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(imagePath),
                ),
              ),
              Text(title),
              Text(
                department,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
              const Text("Technological Field",),
              const Text("Machine Learning | Data Science |DSA",style: TextStyle(color: Colors.blue,fontSize: 12),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.lightbulb_outlined,color: Colors.blue,),
                   const Text("132+",style: TextStyle(color: Colors.blue),),
                  const Icon(Icons.star_border_rounded,color: Colors.blue,),
                  const Text("4.5",style: TextStyle(color: Colors.blue),),
                  Container(
                    width: 80,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 33, 103, 243),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "Apply Now",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
