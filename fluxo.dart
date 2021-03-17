import 'dart:io';
import 'productClass.dart';
import 'helpers.dart';
import 'services.dart';

ProductHelper helper = new ProductHelper();

class Flow {
  void fluxoPrincipal() {
    print("BEM VINDO! ESCOLHA UMA OPÇÃO:");
    print("1 - Fazer Pedido");
    print("2 - Olhar cardapio");
    print("3 - Cancelar Pedido");
    print("4 - Administrativo");
    print("5 - Deletar Cadápio");
    print("6 - sair");
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
          cancelarPedido();
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

  void fazerPedido() {
    print("Aqui é fluxo pedido");
  }

  void verCardapio() {
    productService().getAllProducts();
  }

  void cancelarPedido() {
    print(
        "Estamos cancelando seu pedido. Pedimos desculpas pelos transtornos!");
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
