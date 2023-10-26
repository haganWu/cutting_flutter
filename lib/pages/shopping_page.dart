import 'package:flutter/material.dart';

/// 商城页面
class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('商城页面', style: TextStyle(fontSize: 30, color: Colors.blue)),
      ),
    );
  }
}
