
import 'package:flutter/cupertino.dart';
import 'package:form_blog/src/bloc/login_bloc.dart';
export  'package:form_blog/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{
  static  Provider? _instancia;

  factory Provider({Key ? key,  child}){

        if(_instancia == null){
          _instancia = new Provider._internal(child: child);
        }
        return _instancia!;
  }
  Provider._internal({Key ? key,  child}) : super(key:key , child:child );

  final loginBloc = LoginBloc();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>( ) as Provider).loginBloc;
  }
}