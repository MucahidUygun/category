import 'package:chex/model.dart';
import 'package:chex/services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> navBarItem = [];
  String selectedWorld = '';
  Model? model;
  ValueNotifier<bool> hasData = ValueNotifier(false);

  Future<List<String>> fetch() async {
    navBarItem = await Services.getCategories();
    setState(() {
      selectedWorld = navBarItem.first;
    });
    if (model == null) {
      fetchProducts();
    }
    return navBarItem;
  }

  Future<Model?> fetchProducts() async {
    model = await Services.getProducts(selectedWorld);
    hasData.value = true;
    return model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ARNE NEWS"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FutureBuilder(
                future: fetch(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: navBarItem.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedWorld = navBarItem[index];
                                fetchProducts();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(navBarItem[index],
                                    style: const TextStyle(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
                child: hasData.value 
                    ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: model?.products!.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.amber,
                            height: 75,
                            child: Text(
                                model?.products![index].description! ?? ''),
                          ),
                        );
                      }),
                    )
                    :const Center(child: CircularProgressIndicator()),
                valueListenable: hasData,
                builder: (context, value, child) {
                  return child!;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
