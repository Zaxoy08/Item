import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/product.dart';
import 'add_product.dart';
import 'scan.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<Product> products = [];
  String search = "";

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    products = await DB.getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filtered = products.where((p) =>
      p.name.toLowerCase().contains(search.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context,
            MaterialPageRoute(builder: (_) => AddProduct()));
          load();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "بحث...",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => search = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final p = filtered[i];
                return Card(
                  child: ListTile(
                    title: Text(p.name),
                    subtitle: Text("${p.price} \$"),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
