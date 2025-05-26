import 'package:flutter/material.dart';
class Helper {
  static customAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static Widget buildDrawerItem(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        children: [
          Card(
            surfaceTintColor: const Color.fromARGB(255, 171, 185, 255),
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(title, style: const TextStyle(fontSize: 22)),
                ),
                SizedBox(
                  height: 60,
                  child: Image.asset("assets/smallarrow1.png"),
                ),
              ],
            ),
          ),
          // Image.asset("assets/line4.png"),
        ],
      ),
    );
  }
}