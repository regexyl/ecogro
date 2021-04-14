import 'package:flutter/material.dart';

class AddReceipt extends StatefulWidget {
  @override
  _AddReceiptState createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Receipt'),
      ),
      body: Text('Add Receipt Screen', style: TextStyle(fontSize: 40)),
    );
  }
}