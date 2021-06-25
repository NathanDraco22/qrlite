import 'package:flutter/material.dart';

class  ScanModel {

  int id;
  String valor;
  String tipo;

  ScanModel({this.id,this.tipo,@required this.valor}){

    if ( this.valor.contains("http")){
      this.tipo = "url";
    }else if (this.valor.contains("geo")){
      this.tipo = "geo";
    }else if (this.valor.contains("tel")){
      this.tipo = "tel";
    }else if (this.valor.contains("WIFI")){
      this.tipo = "wifi";
    }else if( valor.contains('www.')){
      this.tipo = "url";
    }else if(this.valor.contains("mailto") ){
      this.tipo = "mail";
    }else if(this.valor.contains("sms:")){
      this.tipo = "sms";
    }else{
      this.tipo = "other";
    }


  }


  factory ScanModel.fromJsonMap(Map<String,dynamic>map){

    return ScanModel(id: map["id"], valor: map["valor"], tipo: map["tipo"] );

  }

  Map <String,dynamic> toMap(){

    return {
      "id"    : this.id,
      "valor" : this.valor,
      "tipo"  : this.tipo
    };

  }




}