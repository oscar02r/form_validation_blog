import 'package:flutter/material.dart';

class ProductoPage extends StatelessWidget {
static final routeName = 'producto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: (){}
          ),
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: (){}
          )
        ],
      ),
      body: Container(),
    );
  }
}
