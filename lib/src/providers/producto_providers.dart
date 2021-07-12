
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:form_blog/src/models/producto_model.dart';

class ProductoProvider {
  final String _url = 'https://flutter-varios-11539-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = Uri.parse('$_url/productos.json');

    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodeData = json.decode(resp.body);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = Uri.parse('$_url/productos/${producto.id}.json');

    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodeData = json.decode(resp.body);
    return true;
  }

  Future <List<ProductoModel>> cargarProductos() async {
    final url = Uri.parse('$_url/productos.json');
    final resp = await http.get(url);
    final List<ProductoModel> productos = [];
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    decodeData.forEach((id, prod) {
        ProductoModel prodTemp = ProductoModel.fromJson(prod);
        prodTemp.id = id;
        productos.add(prodTemp);

    });

    return productos;
  }
  Future<int>  borrarProducto(String id) async{
    final url = Uri.parse('$_url/productos/$id.json');
    final resp = await http.delete(url);
    print(resp.body);
    return 1;
  }
}