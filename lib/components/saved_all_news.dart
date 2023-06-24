import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:up2date/models/storage.dart';

class SavedNewsListTile extends StatefulWidget {
  SavedNewsListTile(this.data, {Key? key}) : super(key: key);
  final Storage data;
  @override
  State<SavedNewsListTile> createState() => _SavedNewsListTileState();
}

class _SavedNewsListTileState extends State<SavedNewsListTile> {
  final user = FirebaseAuth.instance.currentUser!;
  _getRequests() async {}
  @override

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String email = user.email!;
        await Hive.openBox<Storage>(email);
        Navigator.of(context)
            .pushNamed('/SavedArticlePage', arguments: widget.data)
            .then((val)=>{_getRequests()});
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(12.0),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Hero(
                tag: "${widget.data.title ?? "Title"}",
                child: Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.data.urlToImage ??
                          "https://images.unsplash.com/photo-1535696588143-945e1379f1b0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      widget.data.title ?? "Title",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(widget.data.description ?? "Description",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white54,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
