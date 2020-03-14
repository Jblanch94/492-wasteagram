import 'package:flutter/material.dart';

class DetailContent extends StatelessWidget {

  final String content;

  const DetailContent({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Text(content),
      ),
    );
  }
}