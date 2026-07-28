import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/product.dart';
import 'scan.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddProduct> {
  final name = TextEditingController();
  final desc = TextEditingController();
  final price = TextEditingController();
  final barcode = TextEditingController();
  final category = TextEditingController();

  void save() async {
    await DB.insert(Product(
      name: name.text,
      description: desc.text,
      price: double.parse(price.text),
      barcode: barcode.text,
      category: category.text,
    ));
    Navigator.pop(context);
  }

  void scan() async {
    final code = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ScanScreen()),
    );
    if (code != null) barcode.text = code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(controller: name, decoration: InputDecoration(labelText: "اسم")),
          TextField(controller: desc, decoration: InputDecoration(labelText: "وصف")),
          TextField(controller: price, decoration: InputDecoration(labelText: "سعر")),
          TextField(controller: barcode, decoration: InputDecoration(labelText: "باركود")),
          TextField(controller: category, decoration: InputDecoration(labelText: "تصنيف")),
          ElevatedButton(onPressed: scan, child: Text("مسح باركود")),
          SizedBox(height: 20),
          ElevatedButton(onPressed: save, child: Text("حفظ")),
        ],
      ),
    );
  }
}
