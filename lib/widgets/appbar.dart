import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final String appBarTitle;
   CustomAppBar({Key key, this.appBarTitle})
      : super(key: key, title: Text(appBarTitle), centerTitle: true);
}
