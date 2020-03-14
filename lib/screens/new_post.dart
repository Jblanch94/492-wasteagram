import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/appbar.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/waste_posts.dart';
import '../widgets/num_wasted_items_field.dart';
import '../models/waste_posts_services.dart';
import '../widgets/waste_post_upload_button.dart';
import '../widgets/appbar.dart';

class NewPost extends StatefulWidget {
  final File image;
  final Firestore firestore;

  NewPost({Key key, this.image, this.firestore}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  var post = WastePosts();
  var services = WastePostServices();
  String date;

  @override
  void initState() {
    super.initState();
    services.retrieveLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'New Post',
      ),
      body: Column(
        children: <Widget>[
          widget.image == null
              ? CircularProgressIndicator()
              : Flexible(
                  child: Semantics(
                    image: true,
                    label: 'Displaying selected photo',
                    child: FractionallySizedBox(
                      child: Image.file(widget.image),
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                    ),
                  ),
                ),
          Form(
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Semantics(
                    textField: true,
                    label: 'Text field for entering number of wasted items',
                    focused: true,
                    onTapHint:
                        'Enter a numeric value for number of wasted items',
                    value: 'Numeric value for number of wasted items',
                    child: NumberWastedItemsField(post: post),
                  ),
                ),
                Semantics(
                  button: true,
                  label: 'Upload the post to be displayed',
                  onTapHint:
                      'Upload the photo and number of items as part of the post',
                  enabled: true,
                  child: WastePostUploadButton(
                    formKey: widget._formKey,
                    post: post,
                    services: services,
                    image: widget.image,
                    firestore: widget.firestore,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
