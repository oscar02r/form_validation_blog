import 'package:flutter/material.dart';
import 'package:form_blog/src/bloc/provider.dart';
import 'package:form_blog/src/page/producto_page.dart';

class HomePage extends StatelessWidget{
  static final String routeName = 'home' ;
  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page')
      ),
      body: Container(),
      floatingActionButton:  _crearBoton(context),
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