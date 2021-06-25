
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as UL;
import 'package:wifi_configuration/wifi_configuration.dart' as WiU;


class Utils {

  Widget selectIcon(String tipo){
    Map <String,Widget> iconsMap = {

      "url"   : Icon(Icons.language,color: Colors.lightGreenAccent),
      "wifi"  : Icon(Icons.wifi,color: Colors.yellowAccent),
      "geo"   : Icon(Icons.location_on, color: Colors.redAccent,),
      "tel"   : Icon(Icons.phone, color: Colors.cyanAccent),
      "other" : Icon(Icons.sticky_note_2, color: Colors.amberAccent),
      "mail"  : Icon(Icons.mail, color: Colors.orangeAccent),
      "sms"   : Icon(Icons.sms, color: Colors.lightBlueAccent)
    };
    return iconsMap[tipo];
  }

  accionDeScan(BuildContext context,String dataScan) async{
        if (await UL.canLaunch(dataScan)){
        await UL.launch(dataScan);

      }else{
        if (dataScan.contains("WIFI:")){


          Map<String,String>mappingParam = decodeWifiQR(dataScan);

          final String ssid = mappingParam["S"];
          final String password = mappingParam["P"];

          WiU.WifiConfiguration.connectToWifi(ssid,password,"com.example.QRnathan").then(
            (valor){
              if (Navigator.canPop(context)){
                Navigator.of(context).pop();
              }
              switch(valor){
                case WiU.WifiConnectionStatus.connected:
                  showMydialogWifi(context,"Connected to "+ ssid);
                  break;
                case WiU.WifiConnectionStatus.alreadyConnected:
                  showMydialogWifi(context, "Already connected to " + ssid);
                  break;
                case WiU.WifiConnectionStatus.locationNotAllowed:
                  showMydialogWifi(context, "Need to Accept the Location Permission");
                  break;
                case WiU.WifiConnectionStatus.profileAlreadyInstalled:
                  showMydialogWifi(context, "Already connected to " + ssid);
                  break;
                case WiU.WifiConnectionStatus.notConnected:
                  showMydialogWifi(context, "not connected " + ssid);
                  break;
                case WiU.WifiConnectionStatus.platformNotSupported:
                  showMydialogWifi(context, "Platfform not supported");
                  break;
              }

            });
          showMydialogWifi(context, "Connecting to "+ ssid);


        }else{
          showContentDialog(context, dataScan);
        }

      }
  }

  void showMydialogWifi(context, nameWifi){
    showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.blueGrey[900],
          contentPadding: EdgeInsets.all(25.0),
          children: [
          Text("$nameWifi")
          ]
        );
      },
    );

  }

  void showContentDialog(context, conten){
      showDialog(
      context: context,
      builder:(context){
        return SimpleDialog(
          backgroundColor: Colors.blueGrey[900],
          contentPadding: EdgeInsets.all(20.0),
          children: [
            Text("$conten")
          ],
        );
      }
    );
  }


  
  Map<String,String> decodeWifiQR( String wifiCode ){

    String cleanString = wifiCode.replaceAll(RegExp("WIFI:"),"");

    List<String> param = cleanString.split(";");

    param.removeWhere((value) => value == "");

    Iterable<String> iterParam = param.map((valor){
      String itemSinEspacios = valor.replaceAll(RegExp(" "),"");
      return itemSinEspacios;
    });
    Map<String,String> mappingParam = Map.fromIterable(iterParam, 
      key: (v){
       return v.toString().substring(0,1);
      },
      value: (v){
      return v.toString().substring(2,v.toString().length);
      });

    return mappingParam;

  }




}