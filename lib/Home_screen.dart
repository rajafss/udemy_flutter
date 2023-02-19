import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.red,
       centerTitle: true,
       leading: Icon(Icons.menu),
       title: Text('Udemy Title'),
       actions: [
         IconButton(
             onPressed: onNotification,
             icon: Icon(Icons.notifications)),
         // Icon(Icons.notifications),
         IconButton(icon: Text('hello'),onPressed: (){print('Hello');},),
       ],
     ),
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           'Text 1',
           style: TextStyle(
               fontSize: 30,
               color: Colors.white,
               backgroundColor:Colors.red ),),
         Text(
           'Text 2',
           style: TextStyle(
               fontSize: 30,
               color: Colors.white,
               backgroundColor:Colors.green ),),
         Text(
           'Text 3',
           style: TextStyle(
               fontSize: 30,
               color: Colors.white,
               backgroundColor:Colors.blueAccent ),),
         Text(
           'Text 4',style: TextStyle(
             fontSize: 30,
             color: Colors.white,
             backgroundColor:Colors.amberAccent ),),
       ],
     ),
   );
  }
void onNotification(){
    print('notification clicked');
}
}