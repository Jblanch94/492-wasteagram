import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/detail_screen.dart';
import '../models/waste_posts.dart';

class ListScreen extends StatefulWidget {

  final Firestore firestore;

  ListScreen({Key key, this.firestore}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  WastePosts post = WastePosts();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.firestore
            .collection('posts')
            .orderBy("timeStamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length, 
                itemBuilder: (context, index) {
                  var record = snapshot.data.documents[index];
                  return Semantics(
                    label: 'Display post with date and number of wasted items',
                    onTapHint: 'Display all details of the post',
                    child: ListTile(
                      title: Text(record['date'].toString()),
                      trailing: Text(record['numItems'].toString()),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(post: record),
                          ),
                        );
                      },
                    ),
                  );
                }
                  
                );
          } else if (snapshot.data.documents.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return Container();
        });
  }
}
