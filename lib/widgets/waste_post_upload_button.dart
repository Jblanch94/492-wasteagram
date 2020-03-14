import 'package:flutter/material.dart';
import 'dart:io';
import '../models/waste_posts_services.dart';
import '../models/waste_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class WastePostUploadButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final WastePosts post;
  final WastePostServices services;
  final File image;
  final Firestore firestore;

  const WastePostUploadButton(
      {Key key,
      this.formKey,
      this.post,
      this.services,
      this.image,
      this.firestore})
      : super(key: key);

  @override
  _WastePostUploadButtonState createState() => _WastePostUploadButtonState();
}

class _WastePostUploadButtonState extends State<WastePostUploadButton> {
  String date;

  Future<String> sendImage(int timestamp) async {
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(timestamp.toString());
    StorageUploadTask uploadTask = storageRef.putFile(widget.image);
    await uploadTask.onComplete;
    return await storageRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.75,
      child: RaisedButton(
        textColor: Colors.white,
        child: Icon(Icons.cloud_upload),
        onPressed: () async {
          if (widget.formKey.currentState.validate()) {
            widget.formKey.currentState.save();

            //get the current date and set it in dto
            date = widget.services.getCurrentDate();
            widget.post.date = date;

            //get timestamp
            var timestamp = DateTime.now().millisecondsSinceEpoch;

            //set user location
            widget.post.lat = widget.services.locationData.latitude;
            widget.post.long = widget.services.locationData.longitude;

            //set image url
            final url = await sendImage(timestamp);
            widget.post.imageUrl = url;

            //send data to firestore
            widget.firestore.collection('posts').add({
              'date': widget.post.date,
              'numItems': widget.post.numItems,
              'imageURL': widget.post.imageUrl,
              'latitude': widget.post.lat,
              'longitude': widget.post.long,
              'timeStamp': timestamp,
            });

            //go back to listscreen
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
