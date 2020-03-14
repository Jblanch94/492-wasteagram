import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/new_post.dart';

class ImageButton extends StatefulWidget {
  final IconData icon;
  final Firestore firestore;

  const ImageButton({Key key, this.icon, this.firestore})
      : super(key: key);

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {

  var currentTime = DateTime.now().millisecondsSinceEpoch;

  File image;

  Future<File> getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async{
        final image = await getImage();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewPost(image: image, firestore: widget.firestore),
          ),
        );
      },
      child: Icon(widget.icon),
    );
  }
}
