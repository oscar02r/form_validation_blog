
import 'package:flutter/cupertino.dart';
import 'package:form_blog/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{
  Provider({Key ? key,  child}) : super(key:key , child:child );

  final loginBloc = LoginBloc();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType( aspect: Provider ) as Provider).loginBloc;
  }
}