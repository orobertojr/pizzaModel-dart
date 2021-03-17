import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'productClass.dart';

final String productTable = "productTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String descriptionColumn = "descriptionColumn";
final String sizeColumn = "sizeColumn";
final String priceColumn = "priceColumn";
final String typeProductColumn = "typeProductColumn";

class ProductHelper {
  static final ProductHelper _instance = ProductHelper.internal();
  factory ProductHelper() => _instance;
  ProductHelper.internal();
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    open.overrideFor(OperatingSystem.windows, _openOnWindows);
    //open.overrideFor(OperatingSystem.linux, _openOnLinux);
    var db = sqlite3.open("database.db");
    db.execute(
        "CREATE TABLE IF NOT EXISTS $productTable($idColumn INTEGER NOT NULL PRIMARY KEY, $nameColumn TEXT, $descriptionColumn TEXT, $sizeColumn TEXT, $priceColumn TEXT, $typeProductColumn TEXT)");

    return await db;
  }

  Future<Product> saveProduct(Product product) async {
    Database dbProduct = await db;
    dbProduct.execute(
        "INSERT INTO $productTable ($nameColumn, $descriptionColumn, $sizeColumn, $priceColumn, $typeProductColumn) VALUES " +
            "(" +
            "'${product.name}'" +
            ", " +
            "'${product.description}'" +
            ", " +
            "'${product.size}'" +
            ", " +
            "'${product.price}'" +
            ", " +
            "'${product.typeProduct}'" +
            ");");
    product.id = await dbProduct.lastInsertRowId;
    return await product;
  }

  Future<Product> getProduct(int id) async {
    Database dbProduct = await db;
    List<Map> maps = [];
    ResultSet resultSet = await dbProduct.select(
        "SELECT $idColumn, $nameColumn, $descriptionColumn, $sizeColumn, $priceColumn FROM $productTable WHERE $idColumn = $id");
    resultSet.forEach((element) {
      maps.add(element);
    });
    if (maps.length > 0) {
      return Product.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteProduct(int id) async {
    Database dbProduct = await db;
    dbProduct.execute("DELETE FROM $productTable WHERE $idColumn = $id");
    return await dbProduct.getUpdatedRows();
  }

  Future<void> deleteAllTable() async {
    Database dbProduct = await db;
    dbProduct.execute("DELETE FROM $productTable");
  }

  Future<int> updateProduct(Product product) async {
    Database dbProduct = await db;
    dbProduct.execute(
        "UPDATE $productTable SET $nameColumn = '${product.name}', $descriptionColumn = '${product.description}', $sizeColumn = '${product.size}', $priceColumn = '${product.price}' WHERE $idColumn = ${product.id}");
    return await dbProduct.getUpdatedRows();
  }

  Future<List> getAllProducts() async {
    Database dbProduct = await db;
    List listMap = [];
    List<Product> listProduct = [];
    ResultSet resultSet = await dbProduct.select("SELECT * FROM $productTable");
    resultSet.forEach((element) {
      listMap.add(element);
    });
    for (Map m in listMap) {
      listProduct.add(Product.fromMap(m));
    }
    return await listProduct;
  }

  Future close() async {
    Database dbProduct = await db;
    dbProduct.dispose();
  }

  DynamicLibrary _openOnWindows() {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final libraryNextToScript = File('${scriptDir.path}/sqlite3.dll');
    return DynamicLibrary.open(libraryNextToScript.path);
  }

  //Pra Linux
  /*DynamicLibrary _openOnLinux() {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final libraryNextToScript = File('${scriptDir.path}/sqlite3');
    return DynamicLibrary.open(libraryNextToScript.path);
  }*/
}
