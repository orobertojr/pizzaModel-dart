import 'helpers.dart';

class Product {
  int id;
  String name;
  String description;
  String size;
  String price;
  String typeProduct;
  Product(this.name, this.description, this.size, this.price);

  Product.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    description = map[descriptionColumn];
    size = map[sizeColumn];
    price = map[priceColumn];
    typeProduct = map[typeProductColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      descriptionColumn: description,
      sizeColumn: size,
      priceColumn: price,
      typeProductColumn: typeProduct
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Product(id: $id, tipo: $typeProduct, name: $name, descricao: $description, tamanho: $size, preço: $price)";
  }
}

class Macarronada extends Product {
  String typeProduct = "Macarronada";
  Macarronada(String name, String description, String size, String price,
      {typeProduct})
      : super(name, description, size, price);
}

class Pizza extends Product {
  String typeProduct = "Pizza";
  Pizza(String name, String description, String size, String price,
      {typeProduct})
      : super(name, description, size, price);
}

class Sanduiches extends Product {
  String typeProduct = "Sanduiches";
  Sanduiches(String name, String description, String size, String price,
      {typeProduct})
      : super(name, description, size, price);
}

class Bebidas extends Product {
  String typeProduct = "Bebidas";
  Bebidas(String name, String description, String size, String price,
      {typeProduct})
      : super(name, description, size, price);
}
