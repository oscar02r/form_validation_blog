
import 'package:flutter/cupertino.dart';

import 'package:form_blog/src/bloc/login_bloc.dart';
export  'package:form_blog/src/bloc/login_bloc.dart';

import 'package:form_blog/src/bloc/producto_bloc.dart';
export  'package:form_blog/src/bloc/producto_bloc.dart';

class Provider extends InheritedWidget{

  static  Provider? _instancia;
  final _loginBloc = LoginBloc();
  final _productosBloc = ProductosBloc();

  factory Provider({Key ? key,  child}){

        if(_instancia == null){
          _instancia = new Provider._internal(child: child);
        }
        return _instancia!;
  }
  Provider._internal({Key ? key,  child}) : super(key:key , child:child );



  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>( ) as Provider)._loginBloc;
  }

  static ProductosBloc productosBloc (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>( ) as Provider)._productosBloc;
  }
}