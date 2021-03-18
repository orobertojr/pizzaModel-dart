import 'productClass.dart';
import 'pedidoHelpers.dart';

class Pedido {
  int id;
  String nameCliente;
  String price;
  int fk_products;
  int codigo;
  Pedido(this.nameCliente, this.codigo, this.fk_products);

  Pedido.fromMap(Map map) {
    id = map[idColumn];
    nameCliente = map[nameClienteColumn];
    price = map[priceColumn];
    fk_products = map[fk_productColumn];
    codigo = map[codigoColumn];
  }

  String pecoProd(List<Product> products) {
    double preco = 0;
    for (var prod in products) {
      double price = double.parse(prod.price);
      preco = preco + price;
    }
    return this.price = preco.toString();
  }

  @override
  String toString() {
    return "Product(id: $id,nome cliente: $nameCliente, preço: $price, fk_products: $fk_products, codigo Cliente: $codigo)";
  }
}
