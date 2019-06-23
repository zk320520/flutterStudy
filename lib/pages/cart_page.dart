import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/count.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[Number(), MyButton()],
    ));
  }
}

class Number extends StatelessWidget {
  const Number({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text(
            '${counter.value}',
             style: Theme.of(context).textTheme.display1,
          );
        }
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('+'),
      ),
    );
  }
}
