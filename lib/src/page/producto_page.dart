

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_blog/src/models/producto_model.dart';
import 'package:form_blog/src/providers/producto_providers.dart';
import 'package:form_blog/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  static final routeName = 'producto';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey <ScaffoldState>();
  final productoProvider = new ProductoProvider();
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  var _photo ;

  @override
  Widget build(BuildContext context) {
   // if(ModalRoute.of(context)!.settings.arguments != null){
      final   protData = ModalRoute.of(context)?.settings.arguments
      as ProductoModel? ;
   // }



    if(protData != null){
      print('Listo');
      producto = protData;
    }
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () => _procesarImagen(ImageSource.gallery)),
          IconButton(icon: Icon(Icons.camera_alt), onPressed:() => _procesarImagen(ImageSource.camera)),
        ],
      ),
      body: Container(
        
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostratFoto(context),
                _crearNombre(context),
                _crearPrecio(),
                _crearDisponible(context),
                _crearBoton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(BuildContext context) {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      cursorColor: Theme.of(context).primaryColor,
      validator: (value) {
        if (value!.length < 3) {
          return 'El nombre del producto deber mayor que 3.';
        } else {
          return null;
        }
      },
      onSaved: (value) => producto.titulo = value,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(

      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          labelText: 'Precio',
      ),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
      onSaved: (value) => producto.valor = double.tryParse(value!),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      onPressed: _guardando ? null : ()=> _submit(context),
    );
  }

  Widget _crearDisponible(BuildContext context) {
    return SwitchListTile(
        title: Text("Disponible"),
        activeColor: Theme.of(context).primaryColor,
        value: producto.disponible as bool,
        onChanged: (value) => setState(() {
              producto.disponible = value;
            }));
  }

  void _submit(BuildContext context) async {


    if (!formKey.currentState!.validate()) return;
    formKey.currentState?.save();
    setState(() { _guardando = true;});

    if(_photo != null){
      producto.fotoUrl = await productoProvider.uploadImage(_photo);
    }
    if(producto.id == null)
    {
      productoProvider.crearProducto(producto);
      _mostraSnackbar('Producto guardado!', context);
    }else{
      productoProvider.editarProducto(producto);
      setState(() { _guardando = false;});
      _mostraSnackbar('Producto Actualizado!', context);
    }
    Navigator.pop(context);
  }
  void _mostraSnackbar(String mensaje, context){
      final snackBar = SnackBar(
          content: Text('$mensaje'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _mostratFoto(BuildContext context){
    final size = MediaQuery.of(context).size;
    if(producto.fotoUrl != null){
       return Container();
    }else{
      return _photo?.path != null ? Image.file(File(_photo?.path),
          height: size.height * 0.4,
        width: size.width * 0.90,
        fit: BoxFit.fitWidth,
      ):

        Image(
          image: AssetImage( _photo?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  void _procesarImagen(ImageSource source) async{
    final picker = ImagePicker();
    _photo = await picker.getImage(
        source: source
    );

    if(_photo !=null){

    }
    setState(() {});
  }
}
