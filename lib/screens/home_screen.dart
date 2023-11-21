import 'package:flutter/material.dart';
import 'package:pratikum_9/widgets/product_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Elektronik'),
      ),
      body: Center(
        child: Text('Selamat datang di Toko Elektronik!'),
      ),
    );
  }
}
