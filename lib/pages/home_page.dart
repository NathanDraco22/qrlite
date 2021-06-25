

import 'package:QRnathan/providers/scan_list_providers.dart';
import 'package:QRnathan/utils/utils.dart';
import 'package:QRnathan/widgets/boton_scan.dart';
import 'package:QRnathan/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {


    final scanProviderList = Provider.of<ScanListProvider>(context);
    
    scanProviderList.checkInit();

    final listaDeScans = scanProviderList.scansObtenidos;

    final utils = Utils();


    return Scaffold(
      appBar: AppBar(title: Text("QR Scanner"),actions: [
        IconButton(icon:Icon(Icons.delete_forever), 
        onPressed: (){

          if(listaDeScans.length > 0){

            _alertaBorrado(context, scanProviderList);

          }
          


        }
        ,),
        SizedBox(width: 15.0),
      ],),
      body:
        Stack(
          children:[ 
            Center(child: Icon(Icons.qr_code_scanner_outlined, size: 186.0, color: Colors.grey[700],)),


            ListView.builder(
            itemCount: listaDeScans.length,
            itemBuilder: (BuildContext context, int index){
              final scanCard = ScanCard(
                  icono: utils.selectIcon(listaDeScans[index].tipo),
                  texto: listaDeScans[index].valor,
                  );
            
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direct){
                  
                  scanProviderList.borrarID(listaDeScans[index].id);
                },
                child: scanCard ,
              );
              
            },
          ),]
        ),
      floatingActionButton: BotonScan(),
    );
  }

  void _alertaBorrado(BuildContext context, ScanListProvider scanProvider) {

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

        return AlertDialog(
          title: Text("Delete all scans?"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            IconButton(
              onPressed: (){ Navigator.of(context).pop();},
              icon: Text("No")),

            IconButton(
              onPressed: (){
                scanProvider.borrarTodo();
                Navigator.of(context).pop();
              },
              icon: Text("Yes")),

          ],  
          ),
        );
      }
    );
  }



}