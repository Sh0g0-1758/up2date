import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class sidebar extends StatelessWidget {
  sidebar({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jump To',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Home',
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed('/page', arguments: "Home");
            },
          ),
          ListTile(
            title: const Text(
              'Saved Articles',
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () async {
              Hive.openBox<Storage>(user.email!);
              Navigator.of(context)
                  .pushNamed('/SavedArticle', arguments: "Saved Articles");
            },
          ),
          ListTile(
            title: const Text(
              'Software Development',
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/page', arguments: "Software Development");
            },
          ),
          ListTile(
            title: const Text(
              'Cyb3r_S3cur1ty',
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/page', arguments: "Cyb3r_S3cur1ty");
            },
          ),
          ListTile(
            title: const Text(
              "Finance",
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed('/page', arguments: "Finance");
            },
          ),
          ListTile(
            title: const Text(
              "Blockchain",
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed('/page', arguments: "Blockchain");
            },
          ),
          ListTile(
            title: const Text(
              "AI/ML/NLP",
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed('/page', arguments: "AI/ML/NLP");
            },
          ),
          ListTile(
            title: const Text(
              "Quantum Computing",
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/page', arguments: "Quantum Computing");
            },
          ),
          ListTile(
            title: const Text(
              'Hackathons',
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed('/page', arguments: "Hackathons");
            },
          ),
          ListTile(
            title: const Text(
              'CTFs',
              textAlign: TextAlign.center,
            ),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed('/page', arguments: "CTFs");
            },
          ),
        ],
      ),
    );
  }
}
