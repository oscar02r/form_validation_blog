import 'package:flutter/material.dart';
import 'package:form_blog/src/bloc/provider.dart';
import 'package:form_blog/src/page/home_page.dart';
import 'package:form_blog/src/providers/usuario_provider.dart';
import 'package:form_blog/src/utils/utils.dart' as utils;

class LoginPage extends StatelessWidget{
  static final String routeName = 'login' ;
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
        body: Stack(
          children: [
            _crearFondo(context),
            _loginForm(context),
          ],
        ),
  );
  }

  Widget _loginForm(BuildContext context) {

       final bloc = Provider.of(context);

       final size = MediaQuery.of(context).size;
       return SingleChildScrollView(
         child:Column(
           children: [
             Container(height: 230.0),

             Container(
               padding: EdgeInsets.symmetric(vertical: 30.0),
               width: size.width * 0.85,
               decoration: BoxDecoration(
                   color: Colors.white,
                 borderRadius: BorderRadius.circular(5.0),
                 boxShadow: <BoxShadow>[
                   BoxShadow(
                     color: Colors.black26,
                     blurRadius: 3.0,
                     spreadRadius: 3.0,
                     offset: Offset(0.0,5)
                   )
                 ]
               ),
               child: Column(
                 children: [
                   Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                   SizedBox(height: 30.0),
                   _crearEmail(bloc),
                   SizedBox(height: 30.0),
                   _crearPassword(bloc),
                   SizedBox(height: 30.0),
                   _crearBoton(bloc)
                 ],
               ),
             ),
             SizedBox(height: 20.0),
             TextButton(
                 child: Text('Crear nueva cuenta'),
                 onPressed: () => Navigator.pushReplacementNamed(context, 'registro'),
             ),
             SizedBox(height: 20.0),
           ]
         )
       );
  }
  Widget _crearEmail(LoginBloc bloc ) {

    return  StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<String> snashop){

       return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0 ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color:Colors.deepPurple),
                hintText:'example@correo.com',
                labelText: 'Correlo Electronico',
              counterText: snashop.data,
                errorText: snashop.error == null ? null:snashop.error.toString()
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );

  }

  Widget _crearPassword(LoginBloc bloc ) {

    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){

            return  Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0 ),
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_clock_outlined, color:Colors.deepPurple),
                    labelText: 'Contraseña',
                    counterText:snapshot.data,
                  errorText: snapshot.error == null ? null:snapshot.error.toString()
                ),
                onChanged: bloc.changePassword,
              ),
            );
        }
    );


  }
  Widget _crearBoton( LoginBloc bloc) {
    return StreamBuilder(
       stream: bloc.formValidStream ,
        builder: (context, AsyncSnapshot snapshot) {
          return ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
              child: Text('Ingresar'),
            ),
            style:  ElevatedButton.styleFrom(
              elevation: 0.0,
              onPrimary: Colors.white,
              primary: Colors.deepPurple,
              minimumSize: Size(88, 36),
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),

            onPressed: snapshot.hasData ?  ()=> _login(context,bloc): null,
          );
        }
    );
  }

  void _login(BuildContext context , LoginBloc  bloc) async {
    Map info = await   usuarioProvider.login(bloc.email.toString(), bloc.password.toString());
    if(info['ok']){
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }else{
      utils.mostrarAlerta(context, 'Login o password incorrecto.');
    }

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
                 Icon(Icons.person_pin_circle, color: Colors.white, size: 80.0,),
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