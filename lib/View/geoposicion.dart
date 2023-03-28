import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geoposition extends StatefulWidget {
  const Geoposition({Key? key}) : super(key: key);

  @override
  State<Geoposition> createState() => _GeopositionState();
}

class _GeopositionState extends State<Geoposition> {
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();

  late Position position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
                child: ElevatedButton(onPressed: () async {
                  longitud.text= await determinarPosicion().toString();
                }, child: Text('Ubicación')),
              ),
              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
                child:TextField(
                  controller: latitud,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      enabled: false,
                      labelText: "Latitud"
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20, left: 10,right: 10),
                child:TextField(
                  controller: longitud,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      enabled: false,
                      labelText: "Longitud"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Position> determinarPosicion() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(serviceEnabled){

    }else{
      Geolocator.openLocationSettings();
    }
    if(!serviceEnabled){
      return Future.error('No disponible');
    }
    permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('permiso denegado');
      }
    }
    print(await Geolocator.getCurrentPosition());
    return await Geolocator.getCurrentPosition();

  }
}