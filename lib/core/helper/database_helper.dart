// import 'package:path/path.dart' as db_path;
// import 'package:sqflite/sqflite.dart';

// import '../../shopping/model/products_model.dart';

// class DatabaseHelper {
//   static Database? _database;
//   static DatabaseHelper getInstance = DatabaseHelper._();
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     } else {
//       _database = await initDatabase();
//       return _database!;
//     }
//   }

//   ///-----------------------------------------------------------------------------
//   DatabaseHelper._();

//   ///-----------------------------------------------------------------------------

//   initDatabase() async {
//     String path = db_path.join(await getDatabasesPath(), "cartProducts.db");
//     return await openDatabase(path, version: 1,
//         onCreate: (Database db, int v) async {
//       await db.execute('''
//         CREATE TABLE CartProducts (
//         id INTEGER PRIMARY KEY,
//         name TEXT NOT NULL,
//         image TEXT NOT NULL,
//         price REAL NOT NULL,
//         quantity INTEGER NOT NULL)
//         ''');
//     });
//   }

//   Future<void> insertProductToCartInDatabase(ProductsModel cartProduct) async {
//     var dbClient = await database;
//     await dbClient.insert("CartProducts", cartProduct.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<void> updateCartProductQuantityInDatabase(
//       ProductsModel cartProduct) async {
//     var dbClient = await database;
//     await dbClient.update(
//       "CartProducts",
//       cartProduct.toJson(),
//       where: "id = ?",
//       whereArgs: [cartProduct.id],
//     );
//   }

//   Future<ProductsModel?> getCartProductByID(int id) async {
//     var dbClient = await database;
//     List<Map> cartProducts =
//         await dbClient.query("CartProducts", where: "id = ?", whereArgs: [id]);
//     if (cartProducts.isNotEmpty) {
//       return ProductsModel.fromJson(cartProducts.first);
//     }
//     return null;
//   }

//   Future<List<ProductsModel>> getCartProducts() async {
//     var dbClient = await database;
//     List<Map> cartProducts = await dbClient.query("CartProducts");
//     return cartProducts.isNotEmpty
//         ? cartProducts
//             .map((cartProduct) => ProductsModel.fromJson(cartProduct))
//             .toList()
//         : [];
//   }

//   Future<void> deleteCartProduct(int id) async {
//     var dbClient = await database;
//     await dbClient.delete("CartProducts", where: "id = ?", whereArgs: [id]);
//   }
// }
