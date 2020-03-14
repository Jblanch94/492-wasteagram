import 'package:flutter/material.dart';
import '../widgets/detail_content.dart';
import '../widgets/appbar.dart';

class DetailScreen extends StatefulWidget {
  final dynamic post;
  const DetailScreen({Key key, this.post}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'Post Details',
      ),
      body: Column(
        children: <Widget>[
          DetailContent(content: '${widget.post['date']}'),
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Semantics(
                image: true,
                label: 'Photo with corresponding post',
                child: Image.network(widget.post['imageURL'].toString()),
              ),
            ),
          ),
          DetailContent(content: 'Items: ${widget.post['numItems']}'),
          DetailContent(
              content:
                  '(${widget.post['latitude']},  ${widget.post['longitude']})'),
        ],
      ),
    );
  }
}
