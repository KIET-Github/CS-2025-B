// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  final String s;
  final String imageUrl;
  const ArticlePage({
    Key? key,
    required this.s,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  String fetchedText = "Loading...";
  String articleName = "Loading...";
  String type = "Loading...";
  String? imageUrl1;
  bool isLoading = true;
  bool isImageLoading = true;
  String? image;

  @override
  void initState() {
    super.initState();
    fetchTextFromFirestore();
  }

  Future<void> loadImage() async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child('image/$image');
      String url = await ref.getDownloadURL();

      setState(() {
        imageUrl1 = url;
        isImageLoading = false;
      });
    } catch (e) {
      print("Error loading image: $e");
      setState(() {
        isImageLoading = false;
      });
    }
  }

  Future<void> fetchTextFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('texts')
          .doc(widget.s)
          .get();

      if (snapshot.exists) {
        setState(() {
          fetchedText = snapshot.data()?['article'] ?? "No data available";
          articleName = snapshot.data()?['name'] ?? "No data available";
          type = snapshot.data()?['type'] ?? "No data available";
          image = snapshot.data()?['image'] ?? "picture.png";
          loadImage();
        });
      } else {
        setState(() {
          image = "picture.png";
          fetchedText = "No document found";
          articleName = "No document found";
          type = "No document found";
        });
      }
    } catch (e) {
      print("Error fetching text: $e");
      setState(() {
        fetchedText = "Error loading data";
        articleName = "Error loading data";
        type = "Error loading data";
        image = "Error loading data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 400,
        height: 1000,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 24, 96, 252),
              Color.fromARGB(255, 255, 255, 224),
              Colors.white
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      decoration: const BoxDecoration(
                        backgroundBlendMode: BlendMode.lighten,
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      type,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: ( widget.imageUrl != null &&  widget.imageUrl!.isNotEmpty)
                        ? NetworkImage(  widget.imageUrl!)
                        : null,
                    child: (  widget.imageUrl == null ||   widget.imageUrl!.isEmpty)
                        ? const Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.black,
                          )
                        : null,
                  ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 40),
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 150.0, 8.0, 8.0),
                                    child: IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Text(
                                          fetchedText,
                                          style: const TextStyle(fontSize: 16),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 260,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orangeAccent,
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      articleName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        isImageLoading
                            ? const CircularProgressIndicator()
                            : imageUrl1 == null
                                ? const Text('Image not found')
                                : Container(
                                    width:
                                        90, // 2 * radius to match the circle size
                                    height:
                                        90, // 2 * radius to match the circle size
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(55),
                                      color: Colors.white, // Optional: background color if needed
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(55),
                                      child: Image.network(
                                        imageUrl1!,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(Icons.thumb_up_alt_outlined),
                          color: Colors.grey,
                        ),
                        IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(Icons.comment_outlined),
                          color: Colors.grey,
                        ),
                        IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
