import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:up2date/components/drawer.dart';
import 'package:up2date/models/storage.dart';
import 'package:up2date/saved_articles/bloc/saved_article_bloc.dart';
import 'package:up2date/components/saved_all_news.dart';

class SavedArticlepage extends StatefulWidget {
  final String Title;
  SavedArticlepage({super.key, required this.Title});

  @override
  State<SavedArticlepage> createState() => _SavedArticlepageState();
}

class _SavedArticlepageState extends State<SavedArticlepage> {
  final user = FirebaseAuth.instance.currentUser!;

  final SavedArticleBloc savedArticleBloc = SavedArticleBloc();

  @override
  void initState() {
    savedArticleBloc.add(ArticleFetchEvent());
    super.initState();
  }

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
        ],
        title: Text(
          user.email?.split("@").first ?? "User",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      drawer: sidebar(),
      body: ValueListenableBuilder<Box<Storage>>(
        valueListenable: Hive.box<Storage>(user.email!).listenable(),
        builder: (content, box, _) {
          Hive.openBox<Storage>(user.email!);
          List<Storage>? articles = [];
          Box<Storage> box = Hive.box<Storage>(user.email!);
          Iterable<dynamic> Keys = box.keys;
          var it = Keys.iterator;
          while (it.moveNext()) {
            print(it.current);
            articles.add(box.get(it.current)!);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Text(
                              widget.Title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Text(
                              "Enjoy your favourite articles offline",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                    children:
                        articles.map((e) => SavedNewsListTile(e)).toList()),
              ],
            ),
          );
        },
      ),
    );
  }
}
