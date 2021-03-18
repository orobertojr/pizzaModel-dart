import 'helpers.dart';
import 'productClass.dart';
import 'pedidoClass.dart';
import 'pedidoHelpers.dart';

List<Product> products = [];
ProductHelper helper = ProductHelper();
PedidoHelper phelper = PedidoHelper();
Product product;

class productService {
  void saveProduct(Product product) {
    helper.saveProduct(product);
  }

  Future<Product> getProduct(Product product) async {
    Product singleProduct = await helper.getProduct(product.id);
    return singleProduct;
  }

  Future<Product> getProductPeloId(int id) async {
    Product singleProduct = await helper.getProduct(id);
    return await singleProduct;
  }

  void deleteProduct(int id) {
    print(id);
    helper.deleteProduct(id);
  }

  void updateProduct(Product product) {
    print(product.id);
    helper.updateProduct(product);
  }

  Future<List<Product>> getAllProducts() async {
    List<Product> listProduct = [];
    listProduct = await helper.getAllProducts();
    for (Product p in listProduct) {
      print(p);
    }
    return listProduct;
  }

  void deletarDadosTable() {
    helper.deleteAllTable();
  }

  void insertProduct(Product product) {
    helper.saveProduct(product);
  }

  void mostrarCardapio() {
    Macarronada macarronada = new Macarronada(
        "A moda da casa",
        "Macarrão, carne, salsicha, queijo, presunto, bacon, ovos",
        "M",
        22.00.toString());
    insertProduct(macarronada);

    /*insertProduct("Calabresa", "queijo, calabresa,tomate,cebola", "M",
        23.00.toString(), TypeProduct.Pizza);
    insertProduct("Napolitana", "queijo, presunto,tomate,cebola", "F",
        23.00.toString(), TypeProduct.Pizza);
    insertProduct("Bacon", "queijo, bacon,tomate,cebola", "P", 32.00.toString(),
        TypeProduct.Pizza);
    insertProduct(
        "Carne de sol",
        "queijo, carne de sol,queijo coalho,tomate,cebola",
        "M",
        28.00.toString(),
        TypeProduct.Pizza);
    insertProduct("Portuquesa", "queijo, presunto, ovos,tomate,cebola", "M",
        25.00.toString(), TypeProduct.Pizza);
    insertProduct("Simples", "Macarrão, carne, salcicha, queijo ralado", "M",
        16.00.toString(), TypeProduct.Macarronada);
    insertProduct("Especial", "Macarrão, carne, salcicha, queijo e presunto",
        "M", 19.00.toString(), TypeProduct.Macarronada);
    insertProduct(
        "A moda da casa",
        "Macarrão, carne, salsicha, queijo, presunto, bacon, ovos",
        "M",
        22.00.toString(),
        TypeProduct.Macarronada);
    insertProduct("Coca", " ", "1l", 8.00.toString(), TypeProduct.Bebidas);
    insertProduct("Jesus", " ", "1l", 8.00.toString(), TypeProduct.Bebidas);
    insertProduct("Guaraná", " ", "2l", 10.00.toString(), TypeProduct.Bebidas);
    insertProduct("Fanta", " ", "350ml", 5.00.toString(), TypeProduct.Bebidas);
    insertProduct(
        "hambúrguer",
        "pão, carne de hamburquer, queijo, pesunto, salada",
        "único",
        11.00.toString(),
        TypeProduct.Sanduiches);
    insertProduct(
        "x-eggs",
        "pão, carne de hamburquer, queijo, pesunto, ovo, salada",
        "único",
        13.00.toString(),
        TypeProduct.Sanduiches);
    insertProduct(
        "x-bacon",
        "pão, carne de hamburquer, queijo, pesunto, bacon, salada",
        "único",
        15.00.toString(),
        TypeProduct.Sanduiches);
    insertProduct(
        "x-tudo",
        "pão, carne de hamburquer, queijo, pesunto, ovo, bacon, calabresa , salada",
        "único",
        17.00.toString(),
        TypeProduct.Sanduiches);
  */
  }
}
