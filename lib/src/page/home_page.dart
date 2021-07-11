import 'package:flutter/material.dart';
import 'package:form_blog/src/bloc/provider.dart';

class HomePage extends StatelessWidget{
  static final String routeName = 'home' ;
  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Email: ${bloc.email}'),
          Divider(),
          Text('Password: ${bloc.password}'),
        ],
      ),
    );
  }
}