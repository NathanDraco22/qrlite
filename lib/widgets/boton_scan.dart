
import 'package:QRnathan/providers/scan_list_providers.dart';
import 'package:QRnathan/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart' as Scanner;
import 'package:provider/provider.dart';


class BotonScan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      elevation: 20.0,

      child: Icon(Icons.qr_code_scanner,size: 46.0,),
        onPressed: () async{
        final respuesta = await Scanner.FlutterBarcodeScanner.scanBarcode(
          "#00E676",
          "Cancel",
          false,
          Scanner.ScanMode.QR
        );


        if (respuesta != "-1"){

        final providerScanList =Provider.of<ScanListProvider>(context, listen: false);

        providerScanList.nuevoScan(valor: respuesta);

        Utils().accionDeScan(context, respuesta);
        } 





      }
    ,);

  }



}