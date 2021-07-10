
import 'dart:async';

class LoginBloc{

  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  Function(String) get changeEmail => _emailController.add;
  Function(String) get changePassword => _passwordController.add;

  dispose(){
    _passwordController?.close();
    _emailController?.close();
  }

}