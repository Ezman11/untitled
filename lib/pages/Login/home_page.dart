import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FLUTTER FOOD')),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(child: Text("THIS IS A HOME PAGE",style: TextStyle(fontSize: 30,color: Colors.black54,fontWeight: FontWeight.bold ))),
            ),
          ],
        ),
      ),
    );
  }
}