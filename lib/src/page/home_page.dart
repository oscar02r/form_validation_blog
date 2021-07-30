import 'package:flutter/material.dart';
import 'package:form_blog/src/bloc/provider.dart';
import 'package:form_blog/src/models/producto_model.dart';
import 'package:form_blog/src/page/producto_page.dart';

class HomePage extends StatelessWidget{
  static final String routeName = 'home' ;


  @override
  Widget build(BuildContext context) {

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page')
      ),
      body: _crearListado(productosBloc),
      floatingActionButton:  _crearBoton(context),
    );
  }

 Widget _crearListado( ProductosBloc productosBloc){

     return StreamBuilder(
         stream: productosBloc.productosStream ,
         builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
           final productos = snapshot.data;

           if (snapshot.hasData) {
             return ListView.builder(
                 itemCount: productos?.length,
                 itemBuilder: (context, i) => _itemList(productos![i], context, productosBloc)

             );
           } else {
             return Center(
               child: CircularProgressIndicator(),
             );
           }
         }
           );
  }
  Widget _itemList(ProductoModel producto, context, ProductosBloc productosBloc){
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){
        productosBloc.borrarProducto('${producto.id}');
      },
      background: Container(color: Colors.red),
      child: Column(
        children: [
          (producto.fotoUrl == null )
              ?Image(
               image: AssetImage('assets/no-image.png'))
              :FadeInImage(
                height: 300.0,
              width:  double.infinity,
              fit:  BoxFit.cover,
              placeholder: AssetImage('assets/214 jar-loading.gif'),
              image: NetworkImage(producto.fotoUrl.toString())
          ),
          ListTile(
            title:Text('${producto.titulo} - ${producto.valor}'),
            subtitle: Text('${producto.id}'),
            onTap: ()=> Navigator.pushNamed(context, ProductoPage.routeName, arguments: producto),
          ),
        ],
      )
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