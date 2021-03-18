import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'helpers.dart';
import 'pedidoClass.dart';

final String pedidoTable = "pedidoTable";
final String idColumn = "idColumn";
final String nameClienteColumn = "nameClienteColumn";
final String fk_productColumn = "fk_productColumn";
final String priceColumn = "priceColumn";
final String codigoColumn = "codigoColumn";
var helpers = ProductHelper();

class PedidoHelper {
  static final PedidoHelper _instance = PedidoHelper.internal();
  factory PedidoHelper() => _instance;
  PedidoHelper.internal();
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
    var db = sqlite3.open("database.db");
    db.execute(
        "CREATE TABLE IF NOT EXISTS $pedidoTable($idColumn INTEGER NOT NULL PRIMARY KEY, $nameClienteColumn TEXT, $priceColumn TEXT, $codigoColumn INT, $fk_productColumn INT," +
            " FOREIGN KEY($fk_productColumn) REFERENCES productTable(idColumn))");

    return await db;
  }

  Future<Pedido> savePedido(Pedido pedido) async {
    Database dbPedido = await db;
    print(pedido.codigo);
    dbPedido.execute(
        "INSERT INTO $pedidoTable ($nameClienteColumn, $priceColumn, $fk_productColumn,$codigoColumn) VALUES " +
            "(" +
            "'${pedido.nameCliente}'" +
            ", " +
            "'${pedido.price}'" +
            ", " +
            "'${pedido.fk_products}'" +
            ", " +
            "'${pedido.codigo}'" +
            ");");
    pedido.id = await dbPedido.lastInsertRowId;
    return await pedido;
  }

  Future<List> getAllPedido() async {
    Database dbProduct = await db;
    List listMap = [];
    List<Pedido> listPedido = [];
    ResultSet resultSet = await dbProduct.select("SELECT * FROM $pedidoTable");
    resultSet.forEach((element) {
      listMap.add(element);
    });
    for (Map m in listMap) {
      listPedido.add(Pedido.fromMap(m));
    }
    return await listPedido;
  }

  Future<void> deleteAllTable() async {
    Database dbPedido = await db;
    dbPedido.execute("DELETE FROM $pedidoTable");
  }

  DynamicLibrary _openOnWindows() {
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final libraryNextToScript = File('${scriptDir.path}/sqlite3.dll');
    return DynamicLibrary.open(libraryNextToScript.path);
  }
}
