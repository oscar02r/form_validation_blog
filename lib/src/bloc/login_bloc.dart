
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:form_blog/src/bloc/validators.dart';

class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>() ;

  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream , (email, password) => true);

  Function(String) get changeEmail => _emailController.add;
  Function(String) get changePassword => _passwordController.add;

  String? get email => _emailController.valueOrNull;
  String? get password => _passwordController.valueOrNull;

  dispose(){
    _passwordController.close();
    _emailController.close();
  }

}