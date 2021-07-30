import'package:flutter/material.dart';
bool isNumeric(String s){

  if(s.isEmpty) return false;
  final n = num.tryParse(s);

  return (n == null) ? false : true;

}

void mostrarAlerta(BuildContext context, String message){
  showDialog(
      context: context,
    builder: (context){
        return AlertDialog(
          title: Text('Informacion incorrecta'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: Text('Ok')
            )
          ],
        );
    }
  );
}