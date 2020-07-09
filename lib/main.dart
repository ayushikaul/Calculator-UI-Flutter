import 'package:flutter/material.dart';
import './buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>{
  var query = '';
  var answer = ''; 
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String> buttons = [
  'C', 'DEL', '%', '/',
  '9', '8', '7', 'X',
  '6', '5', '4', '+',
  '3', '2', '1', '-',
  '0', '.', 'ANS', '=', 
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Text(query, style: TextStyle(fontSize: 20),),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20),
                  ),
                Container(
                  child: Text(answer, style: TextStyle(fontSize: 20),),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(20),
                  ),
              ],
            ),
          ),
          ),
          Expanded(
          flex: 2 ,
          child: Container(
            child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemBuilder: (BuildContext context, int index){
              
                  if(index == 0){
                  return MyButton(
                  onTap: (){
                    setState(() {
                      query = '';
                    });
                  },
                  buttonText: buttons[index],
                  textColor: Colors.white,
                  color: Colors.green,
                  );
                  }
                  else if(index == 1){
                  return MyButton(
                  onTap: (){
                    setState(() {
                      query = query.substring(0, (query.length)-1);
                    });
                  },
                  buttonText: buttons[index],
                  textColor:  Colors.white,
                  color: Colors.red,
                  );
                  }
                  else if(index == (buttons.length)-1){
                  return MyButton(
                  onTap: (){
                    setState(() {
                      finalAns();
                    });
                  },
                  buttonText: buttons[index],
                  textColor:  Colors.white,
                  color: Colors.deepPurple,
                  );
                  }
                  else{
                  return MyButton(
                  onTap: (){
                    setState(() {
                      query += buttons[index];
                    });
                  },
                  buttonText: buttons[index],
                  textColor:  isSign( buttons[index]) ? Colors.white: Colors.deepPurple,
                  color: isSign( buttons[index]) ? Colors.deepPurple: Colors.deepPurple[50],
                  );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  bool isSign(String x){
    if(x =='%'|| x =='+' || x =='-' || x =='X' || x =='='){
      return false;
    }
    return true;
  }

  void finalAns(){
    String finalQuery = query;
    finalQuery = finalQuery.replaceAll('X', '*');
    finalQuery = finalQuery.replaceAll('%', '*(1/100)');
    Parser p = Parser();
    Expression exp = p.parse('finalQuery');
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }

}