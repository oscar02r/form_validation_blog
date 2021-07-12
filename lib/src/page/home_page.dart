import 'package:flutter/material.dart';
import 'package:form_blog/src/bloc/provider.dart';
import 'package:form_blog/src/models/producto_model.dart';
import 'package:form_blog/src/page/producto_page.dart';
import 'package:form_blog/src/providers/producto_providers.dart';

class HomePage extends StatelessWidget{
  static final String routeName = 'home' ;
  final productoProvider = ProductoProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page')
      ),
      body: _crearListado(),
      floatingActionButton:  _crearBoton(context),
    );
  }

 Widget _crearListado(){
     return FutureBuilder(
         future: productoProvider.cargarProductos() ,
         builder: (context, AsyncSnapshot<List<ProductoModel>> snapshot){
           final productos = snapshot.data;

          if(snapshot.hasData) {
            return ListView.builder(
                 itemCount: productos?.length,
                itemBuilder: (context, i) =>_itemList(productos![i],context)

            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

         }
     );
  }
  Widget _itemList(ProductoModel producto, context){
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){
        productoProvider.borrarProducto('${producto.id}');
      },
      background: Container(color: Colors.red),
      child: ListTile(
        title:Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text('${producto.id}'),
        onTap: ()=> Navigator.pushNamed(context, ProductoPage.routeName),
      ),
    );
  }
  Widget _crearBoton( BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.add),
      onPressed: (){
        Navigator.pushNamed(context, ProductoPage.routeName);
      },
    );
  }
}