import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'pages/index_page.dart';

import './provide/count.dart';
import './provide/child_category.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var providers = Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(child: App(), providers: providers));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
            title: '百姓生活+',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.pink,
            ),
            home: IndexPage()));
  }
}
