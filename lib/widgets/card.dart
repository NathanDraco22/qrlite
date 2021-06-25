import 'package:QRnathan/utils/utils.dart';
import 'package:flutter/material.dart';




class ScanCard extends StatelessWidget {

  ScanCard({this.colorIcon, this.icono, this.texto});

  final Color colorIcon;
  final Icon icono;
  final String texto;


  @override
  Widget build(BuildContext context) {

    Widget contenido;

    if (this.texto.contains("WIFI:")){

      Map<String,String> textDecoded = Utils().decodeWifiQR( texto );
      contenido = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("N: "+textDecoded["S"],style: TextStyle(fontSize: 16.0), ),
          Text("P: "+textDecoded["P"],style: TextStyle(fontSize: 16.0), )
        ],
      );
    }else{
      contenido =Text(texto,style: TextStyle(fontSize: 16.0),);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey[300], width: 3.0),
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.blueGrey[900]

        ),
      margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
      child: Row(
          children: [
            SizedBox(width: 5.0,),
            Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white), 
                borderRadius: BorderRadius.circular(30.0) ),
            child: IconButton(
              highlightColor: Colors.yellowAccent,
              iconSize: 40.0,
              icon: this.icono,
              onPressed: (){
                Utils().accionDeScan(context, this.texto);
              },
              

              ), 
            ),
            SizedBox(width: 15.0 , height: 70.0,),
            Container(
              width: 250.0,
              child: contenido
              )
          ],) ,
        
        
        
        
    );
  
  
  
  }
}