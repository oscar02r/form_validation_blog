import 'package:flutter/material.dart';
import 'package:form_blog/src/models/producto_model.dart';
import 'package:form_blog/src/providers/producto_providers.dart';
import 'package:form_blog/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  static final routeName = 'producto';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductoProvider();
  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    final ProductoModel protData = ModalRoute.of(context)!.settings.arguments
    as ProductoModel;

    if(protData != null){
      producto = protData;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _crearNombre(context),
              _crearPrecio(),
              _crearDisponible(context),
              _crearBoton(context)
            ],
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
      onPressed: _submit,
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

  void _submit() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState?.save();
    if(producto.id == null)
    {
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.editarProducto(producto);
    }
  }
}
