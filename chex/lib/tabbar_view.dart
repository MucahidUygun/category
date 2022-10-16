import 'package:flutter/material.dart';

class TabbarView extends StatefulWidget {
  TabbarView({Key? key}) : super(key: key);

  @override
  State<TabbarView> createState() => _TabbarViewState();
}

List<String> categories = ["a", "b", "c", "d", "e", "f", "g", "h"];

class _TabbarViewState extends State<TabbarView> {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Title"),
            bottom: TabBar(
              isScrollable: true,
              tabs: List<Widget>.generate(categories.length, (int index) {
                return const Tab(text: "some random text");
              }),
            ),
          ),
          body: TabBarView(
            children: List<Widget>.generate(
              categories.length,
              (int index) {
                return Center(
                    child: Text("again some random text" + categories[index]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
