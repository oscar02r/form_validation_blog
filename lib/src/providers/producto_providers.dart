
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
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

  Future<String> uploadImage(File image) async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dtfvbtscn/image/upload?upload_preset=jbajnsrc');
    final mimeType = mime(image.path)!.split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
        'file',
        image.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await  http.Response.fromStream(streamResponse);
    if(resp.statusCode !=200 && resp.statusCode !=201){
      print('Algo salio mal');
      print ('${resp.body}');
      return '';
    }
    final dataResp = json.decode(resp.body);
    return dataResp['secure_url'];
  }
}