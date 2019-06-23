import 'package:flutter/material.dart';

class FloorTitle extends StatelessWidget {
  final String pictureAddress;
  const FloorTitle({Key key, this.pictureAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Image.network(this.pictureAddress),
    );
  }
}