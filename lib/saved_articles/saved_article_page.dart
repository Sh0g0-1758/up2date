import 'package:flutter/material.dart';
import 'package:up2date/models/storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedArticleContentPage extends StatefulWidget {
  final Storage data;
  SavedArticleContentPage({super.key, required this.data});
  @override
  State<SavedArticleContentPage> createState() =>
      _SavedArticleContentPageState();
}

class _SavedArticleContentPageState extends State<SavedArticleContentPage> {
  final user = FirebaseAuth.instance.currentUser!;
  deleteArticle(String url) {
    setState(() {
      Box<Storage> box = Hive.box<Storage>(user.email!);
      box.delete(url);
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            "Article successfully deleted !",
            style: const TextStyle(color: Colors.white),
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange.shade900),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                deleteArticle(widget.data.url!);
              },
              child: Text("Delete this article")),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.title ?? "Title",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                widget.data.author ?? "Author",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Hero(
                tag: "${widget.data.title}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(widget.data.urlToImage ??
                      "https://images.unsplash.com/photo-1535696588143-945e1379f1b0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80"),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                widget.data.description ?? "Description",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(widget.data.content ?? "Content of the aticle ..... "),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final String safeurl = Uri.encodeFull(
                          widget.data.url ?? "https://theuselessweb.com");
                      final Uri url = Uri.parse(safeurl);
                      await launchUrl(url);
                    },
                    child: const Text(
                      "To Read this article, click here",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
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
}
