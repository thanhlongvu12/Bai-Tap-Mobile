import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget{

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>{

  Widget calButton(String btnTxt, Color btnColor, Color txtColor){
    return Container(
      child: SizedBox(
        width: 88,
        height: 88,
        child: ElevatedButton(
          onPressed: () {
            if(text.toString().length < 6) {
              calculation(btnTxt);
            }else if(btnTxt == 'AC'){
              text = '0';
            }
            // calculation(btnTxt);
          },
          child: Text('$btnTxt',
            style: TextStyle(
              fontSize: 35,
              color: txtColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: btnColor,
            padding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Calculator'),backgroundColor: Colors.black,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Callculator display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text('$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                    fontSize: 100
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('AC', Colors.grey, Colors.black),
                calButton('+/-', Colors.grey, Colors.black),
                calButton('%', Colors.grey, Colors.black),
                calButton('/', Colors.grey, Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('7', Colors.grey, Colors.black),
                calButton('8', Colors.grey, Colors.black),
                calButton('9', Colors.grey, Colors.black),
                calButton('x', Colors.grey, Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('4', Colors.grey, Colors.black),
                calButton('5', Colors.grey, Colors.black),
                calButton('6', Colors.grey, Colors.black),
                calButton('-', Colors.grey, Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('1', Colors.grey, Colors.black),
                calButton('2', Colors.grey, Colors.black),
                calButton('3', Colors.grey, Colors.black),
                calButton('+', Colors.grey, Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(

                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('0',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    ),
                  ),
                ),
                calButton('3', Colors.grey, Colors.black),
                calButton('=', Colors.grey, Colors.black),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';



  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if( opr == '=' && btnText == '=') {
        if (preOpr == '+') {
          finalResult = add();
        } else if (preOpr == '-') {
          finalResult = sub();
        } else if (preOpr == 'x') {
          finalResult = mul();
        } else if (preOpr == '/') {
          finalResult = div();
        }
    }
    else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
        if (opr == '+') {
          finalResult = add();
        } else if (opr == '-') {
          finalResult = sub();
        } else if (opr == 'x') {
          finalResult = mul();
        } else if (opr == '/') {
          finalResult = div();
        }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
