import 'dart:ffi';
import 'dart:io';
import 'productClass.dart';
import 'helpers.dart';
import 'services.dart';
import 'pedidoClass.dart';
import 'pedidoHelpers.dart';
import 'dart:math';
import 'pedidoService.dart';

ProductHelper helper = new ProductHelper();
PedidoHelper phelper = new PedidoHelper();

class Flow {
  void fluxoPrincipal() {
    print("BEM VINDO! ESCOLHA UMA OPÇÃO:");
    print("1 - Fazer Pedido");
    print("2 - Olhar cardapio");
    print("3 - Excluir todos os Pedido");
    print("4 - Administrativo");
    print("5 - Deletar Cadápio");
    print("6 - Olhar Todos os Pedidos");
    print("7 - sair");
    var input = stdin.readLineSync();
    switch (input) {
      case "1":
        {
          fazerPedido();
        }
        break;
      case "2":
        {
          verCardapio();
        }
        break;
      case "3":
        {
          excluiTodosPedidos();
        }
        break;
      case "4":
        {
          fluxoAdm();
        }
        break;
      case "5":
        {
          limparCardapio();
        }
        break;
      case "6":
        {
          verTodosPedidos();
        }
        break;
      default:
        break;
    }
  }

  void fluxoAdm() {
    print("ESCOLHA UMA OPÇÃO");
    print("1 - Adicionar NovosProdutos");
    print("2 - Voltar ao menu principal");
    var input2 = stdin.readLineSync();
    switch (input2) {
      case "1":
        {
          adicionaProduto();
        }
        break;
      default:
        {
          fluxoPrincipal();
        }
    }
  }

  void fazerPedido() async {
    await productService().getAllProducts();
    var continuarPedindo = true;
    var rad = new Random();
    int cod = rad.nextInt(1000);
    List<int> produtos = [];
    print("Informe seu nome");
    var nome = stdin.readLineSync();
    while (continuarPedindo) {
      print("Informe o id do produto");
      var idProd = stdin.readLineSync();
      int id = int.parse(idProd);
      produtos.add(id);
      print("Deseja continuar:(S - sim ou N- não)");
      var resp = stdin.readLineSync();
      if (resp == 'S') {
        continue;
      } else {
        continuarPedindo = false;
      }
    }

    double price = 0.0;
    for (int i in produtos) {
      Product produto = await productService().getProductPeloId(i);
      price = price + double.parse(produto.price);
    }
    for (int j in produtos) {
      Pedido pedidoTeste = Pedido(nome, cod, j);
      pedidoTeste.price = price.toString();
      pedidoTeste.codigo = cod;
      phelper.savePedido(pedidoTeste);
    }
    print("Pedido salvo seu codigo é: ");
    print(cod);
    fluxoPrincipal();
  }

  void verCardapio() async {
    await productService().getAllProducts();
    fluxoPrincipal();
  }

  void verTodosPedidos() async {
    await PedidoService().getAllPedidos();
    fluxoPrincipal();
  }

  void cancelarPedido() {
    print(
        "Estamos cancelando seu pedido. Pedimos desculpas pelos transtornos!");
  }

  void excluiTodosPedidos() {
    phelper.deleteAllTable();
    fluxoPrincipal();
  }

  void limparCardapio() {
    print("Deseja exluir todos os itens do cardapio?");
    print("S- sim");
    print("N- não");
    var resp = stdin.readLineSync();
    if (resp == 'S') {
      productService().deletarDadosTable();
      print("Todos os dados foram excluidos!");
    } else {
      fluxoPrincipal();
    }
  }

  void adicionaProduto() {
    print("Escolha o tipo de Produto: ");
    print("1 - MACARRONADA");
    print("2 - PIZZA");
    print("3 - SANDUICHE");
    print("4 - BEBIDA");
    var input = stdin.readLineSync();
    print("Insira o nome do Produto");
    var name = stdin.readLineSync();
    print("Insira a descrição:");
    var description = stdin.readLineSync();
    print("Qual o tamanho?");
    var size = stdin.readLineSync();
    print("Qual o preço?");
    var price = stdin.readLineSync();
    switch (input) {
      case '1':
        {
          helper.saveProduct(new Macarronada(name, description, size, price));
        }
        break;
      case '2':
        {
          helper.saveProduct(new Pizza(name, description, size, price));
        }
        break;
      case '3':
        {
          helper.saveProduct(new Sanduiches(name, description, size, price));
        }
        break;
      case '4':
        {
          helper.saveProduct(new Bebidas(name, description, size, price));
        }
        break;
      default:
        {
          print("Escolha uma opção válida");
          adicionaProduto();
        }
    }
  }
}
