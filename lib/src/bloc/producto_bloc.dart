
import 'package:form_blog/src/models/producto_model.dart';
import 'package:form_blog/src/providers/producto_providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc{
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargarndoController = new BehaviorSubject<bool >();
  final _productosProvider = new ProductoProvider();

  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Stream <bool> get cargandoStream => _cargarndoController.stream;

  void cargarProductos () async{
       final productos = await _productosProvider.cargarProductos();
       _productosController.sink.add(productos);
  }

  void agregandoProducto(ProductoModel producto) async {

        _cargarndoController.sink.add(true);
        await _productosProvider.crearProducto(producto);
        _cargarndoController.sink.add(false);
  }

  Future<String> subirFoto(PickedFile image) async{
    _cargarndoController.sink.add(true);
   final fotoUrl = await _productosProvider.uploadImage(image);
    _cargarndoController.sink.add(false);
    return fotoUrl;
  }

  void editarProducto(ProductoModel producto) async {

    _cargarndoController.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargarndoController.sink.add(false);
  }

  void borrarProducto(String id) async {
    await _productosProvider.borrarProducto(id);
  }


  dispose(){
    _productosController?.close();
    _cargarndoController?.close();
  }
}