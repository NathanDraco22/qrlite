import 'package:QRnathan/pages/home_page.dart';
import 'package:QRnathan/providers/scan_list_providers.dart';
import 'package:QRnathan/providers/state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



void main(){



  runApp(QRNathan());
}





class QRNathan extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UpdateState(),),
        ChangeNotifierProvider(create: (_) => ScanListProvider(),)
      ],

      child: MaterialApp(
        title: "QR Scan Lite",
        home:   HomePage(),
        theme:  ThemeData.dark(),
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}