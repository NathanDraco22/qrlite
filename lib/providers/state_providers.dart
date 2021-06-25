
import 'package:flutter/material.dart';

class UpdateState extends ChangeNotifier{

  int contar = 10;

  void tryUpdate(){
    contar +=1;
    notifyListeners();
  }
}