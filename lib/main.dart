import 'package:flutter/material.dart';
import 'package:form_blog/src/bloc/provider.dart';
import 'package:form_blog/src/page/home_page.dart';
import 'package:form_blog/src/page/login_page.dart';
import 'package:form_blog/src/page/producto_page.dart';
import 'package:form_blog/src/page/registro_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FormBlog',
        initialRoute: LoginPage.routeName,
        routes: {
          HomePage.routeName  : (BuildContext context) => HomePage(),
          RegistroPage.routeName: (BuildContext context) => RegistroPage(),
          LoginPage.routeName : (BuildContext context) => LoginPage(),
          ProductoPage.routeName : (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,

        )
      )
    );


  }
}