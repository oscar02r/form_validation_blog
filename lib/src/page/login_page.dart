import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  static final String routeName = 'login' ;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
        body: Stack(
          children: [
            _crearFondo(context)
          ],
        ),
  );
  }

 Widget _crearFondo(BuildContext context) {
      final size = MediaQuery.of(context).size;
       return Container(
               height: size.height * 0.40,
               width: double.infinity,
          decoration:BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(63, 63, 156, 1.0),
                Color.fromRGBO(90, 70, 178, 1.0)
              ]
            )
          ),
       );
  }
}