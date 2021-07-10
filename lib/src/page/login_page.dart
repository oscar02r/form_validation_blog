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
       final fondoMorado = Container(
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


       final crearCirculo = Container(
         height: 100.0,
         width: 100.0,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(100.0),
           color: Color.fromRGBO(255, 255, 255, 0.05)
         ),
       );


       return Stack(
         children: [
           fondoMorado,
           Positioned(child: crearCirculo, top: 90.0, left: 30.0),
           Positioned(child: crearCirculo, top: -40.0, right:-30.0),
           Positioned(child: crearCirculo, bottom: -50.0, left: -10.0),
           Positioned(child: crearCirculo, bottom: 120, right: 20.0),
           Positioned(child: crearCirculo, bottom: -50, right:- 20.0),
           Container(
             padding: EdgeInsets.only(top: 80.0),
             child: Column(

               children: [
                 Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
                 SizedBox(height: 10.0, width: double.infinity,),
                 Text('Oscary Ramirez', style: TextStyle(
                     fontSize: 25.0,
                     color: Colors.white
                 ),
                 )
               ],
             ),
           )
         ],
       );
  }
}