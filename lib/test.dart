import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.grey[400],
                Colors.grey[900],
                Colors.grey[900],
                Colors.grey[400]
              ], stops: [
                0.0,
                0.4,
                0.6,
                1.0
              ], begin: Alignment.bottomLeft, end: Alignment.topRight),
            ),
          ),
        ],
      ),
    );
  }
}




//  onTap: () {
//                   showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           content: Text("Want to But Item?"),
//                           actions: [
//                             MaterialButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 "No",
//                                 style: TextStyle(
//                                   color: Colors.deepPurple,
//                                 ),
//                               ),
//                             ),
//                             MaterialButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 openCheckout();
//                               },
//                               child: Text("Buy",
//                                   style: TextStyle(
//                                     color: Colors.deepPurple,
//                                   )),
//                             ),
//                           ],
//                         );
//                       });
//                 },
            