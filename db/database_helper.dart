import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DB {
  static Database? _db;

  static Future<Database> get() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'products.db'),
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          price REAL,
          barcode TEXT,
          category TEXT,
          image TEXT
        )
        ''');
      },
      version: 1,
    );
    return _db!;
  }

  static Future insert(Product p) async {
    final db = await get();
    return db.insert('products', p.toMap());
  }

  static Future<List<Product>> getAll() async {
    final db = await get();
    final data = await db.query('products');

    return data.map((e) => Product(
      id: e['id'] as int,
      name: e['name'] as String,
      description: e['description'] as String,
      price: e['price'] as double,
      barcode: e['barcode'] as String,
      category: e['category'] as String,
      image: e['image'] as String?,
    )).toList();
  }
}
