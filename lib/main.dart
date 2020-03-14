import 'package:flutter/material.dart';
import 'app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(firestore: Firestore.instance));
}
