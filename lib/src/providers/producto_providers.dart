
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:form_blog/src/models/producto_model.dart';

class ProductoProvider{
  final String _url = 'https://flutter-varios-11539-default-rtdb.firebaseio.com';

  Future<bool> crearProducto( ProductoModel producto) async{
    final url = Uri.parse('$_url/productos.json') ;

    final resp = await http.post(url,body: productoModelToJson(producto) );
    final decodeData =  json.decode(resp.body);
    return true;
  }


}