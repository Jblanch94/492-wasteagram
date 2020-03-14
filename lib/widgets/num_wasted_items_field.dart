import 'package:flutter/material.dart';
import '../models/waste_posts.dart';

class NumberWastedItemsField extends StatefulWidget {

  final WastePosts post;

  const NumberWastedItemsField({Key key, this.post}) : super(key: key);

  @override
  _NumberWastedItemsFieldState createState() => _NumberWastedItemsFieldState();
}

class _NumberWastedItemsFieldState extends State<NumberWastedItemsField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Number of Items field can not be empty';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        var intValue = int.parse(value);
        widget.post.numItems = intValue;
      },
      decoration: InputDecoration(
        labelText: 'Enter Number of Items wasted',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
