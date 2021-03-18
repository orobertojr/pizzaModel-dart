import 'pedidoClass.dart';
import 'pedidoHelpers.dart';

PedidoHelper phelper = PedidoHelper();

class PedidoService {
  void inserePedidos(Pedido pedido) {
    phelper.savePedido(pedido);
  }

  Future<List<Pedido>> getAllPedidos() async {
    List<Pedido> listPedidos = [];
    listPedidos = await phelper.getAllPedido();
    for (Pedido p in listPedidos) {
      print(p);
    }
    return listPedidos;
  }
}
