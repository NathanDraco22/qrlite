


import 'package:flutter/material.dart';

class TileScans extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return 
      Column(
      children: [
        ListTile(
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyanAccent,),
          title: Text("demostracion", style: TextStyle(fontSize: 16.0),),
        
        )
    ]);
  }




}