import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/list_screen.dart';
import './widgets/image_button.dart';
import './widgets/appbar.dart';

class App extends StatefulWidget {
  final Firestore firestore;

  const App({Key key, this.firestore}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int numPosts = 0;
  

  @override
  void initState() {
    super.initState();
    widget.firestore.collection('posts').snapshots().listen((snapshot) {
      setState(() {
        numPosts = snapshot.documents.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          splashColor: Colors.orange[800],
        ),
        appBarTheme: AppBarTheme(
          color: Colors.red[500],
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
      ),
      home: Scaffold(
        appBar: CustomAppBar(
          appBarTitle: 'Wasteagram - $numPosts',
        ),
        body: ListScreen(firestore: widget.firestore),
        floatingActionButton: Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Select a photo',
          label: 'Tap button to make a new post after selecting photo',
          child: ImageButton(icon: Icons.camera_alt, firestore: widget.firestore),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
