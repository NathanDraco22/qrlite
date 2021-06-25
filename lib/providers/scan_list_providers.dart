import 'package:QRnathan/models/scan_model.dart';
import 'package:QRnathan/providers/db_providers.dart';
import 'package:flutter/cupertino.dart';


class ScanListProvider extends ChangeNotifier{

  bool initSession = true;

  List<ScanModel> scansObtenidos = [] ;

  nuevoScan ( {String valor}) async {
    final nuevoScanModel = new ScanModel(valor: valor);

    final idDB = await DbProviders.db.nuevoScan(nuevoScanModel);

    nuevoScanModel.id = idDB;

    this.scansObtenidos.add(nuevoScanModel);
    notifyListeners();

    
  }

  cargarScans () async {
    final todosScans = await DbProviders.db.obtenerTodosScanss();

    this.scansObtenidos = [...todosScans];


    notifyListeners();
  }


  borrarTodo()async{
    final scansBorrados = await DbProviders.db.borrarTodoScans();
    cargarScans();
    return scansBorrados;

  }

  borrarID(int idBorrar) async {

    print(idBorrar);

    final scanBorrado = await DbProviders.db.borrarById(idBorrar);
    cargarScans();

    print(scanBorrado);

    return scanBorrado;
  }
  
  borrarValor(String valorBorrar) async {

    print(valorBorrar);

    final scanBorrado = await DbProviders.db.borrarByValor(valorBorrar);
    cargarScans();

    print(scanBorrado);

    return scanBorrado;
  }


  obtenerScanID(int idInt) async {

    final scanObtenido = await DbProviders.db.obtenerScanID(idInt);

    print(scanObtenido.valor);
    print(scanObtenido.id);


  }

  checkInit(){

    if (this.initSession){

      this.cargarScans();
      this.initSession = false;

    }
  }



}