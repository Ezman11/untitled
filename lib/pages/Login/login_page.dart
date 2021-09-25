import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var input = '';
  int inputSize = 6;
  int inputCount = 0;

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // ไล่เฉดจากมุมบนซ้ายไปมุมล่างขวาของ Container
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // ไล่เฉดจากสีแดงไปสีน้ำเงิน
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFF73C8EF)
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 100.0,
                            color: Colors.black54,
                          ),
                          Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 35,color: Colors.black54 , fontWeight: FontWeight.bold),
                          ),
                          Text('Enter PIN to login',style: TextStyle(fontSize: 20,color: Colors.black54 )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(var i=0;i<inputCount;i++)
                            Icon(Icons.circle,color: Color(0xFF66B0D4),size: 30,),
                          for(var i=0;i<inputSize-inputCount;i++)
                            Icon(Icons.circle,color: Colors.white,size: 30)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    [-2, 0, -1],
                  ].map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoginButton(
                            number: item,
                            onClick: _handleClickButton,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _handleClickButton(int num) {
    print('Input : $num');
    setState(() {
      if(num>-1){
        if(inputCount<inputSize){
          inputCount++;
          input = input + num.toString();
        }
      }else if(num==-1){
        if(inputCount>0){
          inputCount--;
          input = input.substring(0, input.length - 1);
        }
      }
      print('$inputCount / $inputSize : $input');
      if(inputCount==inputSize){
        if(input=='123456'){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }else{
          _showMaterialDialog('ERROR', 'Invalid PIN Please try again.');
        }
        inputCount=0;
        input='';
      }
    });
  }
}


class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    required this.number,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: (){
        onClick(number);
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: number == -2 ? null :BoxDecoration(
            color: Color(0xFFE6FCFF),
            shape: BoxShape.circle, border: Border.all(width: 2.0)),
        child: Center(
          child: number >= 0 ? Text(
            '$number',
            style: Theme.of(context).textTheme.headline6,
          ) : (number == -1 ? Icon(Icons.backspace_outlined) : SizedBox.shrink()),
        ),
      ),
    );
  }
}