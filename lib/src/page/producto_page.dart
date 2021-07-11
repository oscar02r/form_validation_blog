import 'package:flutter/material.dart';
import 'package:form_blog/src/utils/utils.dart' as utils ;

class ProductoPage extends StatefulWidget {
static final routeName = 'producto';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: (){}
          ),
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: (){}
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key:formKey,
          child: Column(
            children: [
              _crearNombre(context),
              _crearPrecio(),
               _crearBoton(context)
            ],
          ),
        ),
      ),
    );
  }

 Widget _crearNombre(BuildContext context) {
    return TextFormField(

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      cursorColor: Theme.of(context).primaryColor,
      validator: ( value){
         if(value!.length < 3){
             return 'El nombre del producto deber mayor que 3.';
         }else{
           return null;
         }
      },
    );
 }

Widget  _crearPrecio() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      validator: (value){
        if(   utils.isNumeric(value!)){
          return null;
        }else{
          return 'Solo numeros';
        }

      }
    );
}

 Widget _crearBoton(BuildContext context ) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          )
        ),
        icon: Icon(Icons.save),
        label: Text('Guardar'),
      onPressed:_submit,
    );
 }

  void _submit() {
    if(!formKey.currentState!.validate()) return;
    print('Todo Okay');
  }
}
