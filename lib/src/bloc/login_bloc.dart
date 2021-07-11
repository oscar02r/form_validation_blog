
import 'dart:async';

import 'package:form_blog/src/bloc/validators.dart';

class LoginBloc with Validators {

  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Function(String) get changeEmail => _emailController.add;
  Function(String) get changePassword => _passwordController.add;

  dispose(){
    _passwordController.close();
    _emailController.close();
  }

}