import 'dart:convert';
import 'dart:async';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import '../DTO/User.dart';
import 'admin.dart';
import 'geoposicion.dart';
import 'invitado.dart';
import 'package:local_auth/local_auth.dart';


class Login extends StatefulWidget{

  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login> {
  User objUser = User();
  bool _password = false;

  TextEditingController nombre = TextEditingController();
  TextEditingController password = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();
  validarDatos() async{
    bool flag = false;
    try{
        String hashedPasswordUsuario = sha256.convert(utf8.encode(password.text)).toString();
        CollectionReference ref = FirebaseFirestore.instance.collection('Usuarios');
        QuerySnapshot usuario = await ref.get();
        bool validar = true;
        if(usuario.docs.length !=0){
          //hace un recorrido por todos los documentos
          for(var cursor in usuario.docs){
            if(cursor.get("NombreUsuario")== nombre.text || cursor.get("EmailUsuario")== nombre.text ){
              print('usuario encontrado');
              validar = true;
              //mensaje("datos correctos", "bienvenido");
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Inicio()));
                if(cursor.get("passwordUsuario") == hashedPasswordUsuario){
                  //mensaje("datos correctos", "bienvenido", objUser);
                  objUser.nombre = cursor.get('NombreUsuario');
                  objUser.email = cursor.get('EmailUsuario');
                  objUser.rol = cursor.get('Rol');
                  objUser.estado=cursor.get('Estado');
                  mensaje('Mensaje', 'dato encontrado', objUser);
                  if(cursor.get("rol") == "admin"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => admin()));
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => invitado()));
                  }
                  break;
                }else{
                  mensaje("datos incorrectos o nulos", "intente de nuevo", objUser);
                  break;
                }
              }else {
              validar = false;
              }
            }if(validar == false){
            mensaje("usuario incorrecto", "intentar de nuevo",objUser);
          }
        }
    }catch(e){
      print('error en insert...........' + e.toString());
      mensaje("datos incorrectos o nulos", "intente de nuevo",objUser);
    }
  }
  void mensaje(String titulo , String contenido, User objUser){
    showDialog(context: context, builder: (buildcontext){
      return AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: <Widget>[
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Aceptar', style: TextStyle(color: Colors.white),),
          )
        ],);
    });
  }
  Future<bool> biometrico() async {
    //print("biométrico");

    // bool flag = true;
    bool authenticated = false;

    const androidString = const AndroidAuthMessages(
      cancelButton: "Cancelar",
      goToSettingsButton: "Ajustes",
      signInTitle: "Ingrese",
      //fingerprintNotRecognized: 'Error de reconocimiento de huella digital',
      goToSettingsDescription: "Confirme su huella",

      //fingerprintSuccess: 'Reconocimiento de huella digital exitoso',
      biometricHint: "Toque el sensor",
      //signInTitle: 'Verificación de huellas digitales',
      biometricNotRecognized: "Huella no reconocida",
      biometricRequiredTitle: "Required Title",
      biometricSuccess: "Huella reconocida",
      //fingerprintRequiredTitle: '¡Ingrese primero la huella digital!',
    );
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    // bool isBiometricSupported = await auth.();
    bool isBiometricSupported = await auth.isDeviceSupported();

    List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();
    print(canCheckBiometrics); //Returns trueB
    // print("support -->" + isBiometricSupported.toString());
    print(availableBiometrics.toString()); //Returns [BiometricType.fingerprint]
    try {
      authenticated = await auth.authenticate(
          localizedReason: "Autentíquese para acceder",
          useErrorDialogs: true,
          stickyAuth: true,
          //biometricOnly: true,
          androidAuthStrings: androidString);
      if (!authenticated) {
        authenticated = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }
    /* if (!mounted) {
        return;
      }*/

    return authenticated;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ingresar login'),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 10, left: 10,right: 10),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image(image: AssetImage('assent/user.png'),),
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nombre,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Nombre de Usuario',
                    hintText: 'Digite Nombre de Usuario',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: _password,
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon:Icon(Icons.password),
                    labelText: 'password',
                    hintText: 'Digite password',
                      suffixIcon: IconButton(
                          icon: Icon(_password ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _password = !_password;
                            });
                          }
                      )
                    //obscureText: true,/* <-- Aquí */
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    print('botón presionado');
                    validarDatos();
                    //nombre.clear();
                    //password.clear();
                  },
                  child: Text('entrar'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () async{
                    print('botón presionado');
                    if(await biometrico()){
                      mensaje("huella", "Huella encontrada",objUser);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Geoposition()));
                    }

                  },
                  child: Icon(Icons.fingerprint,size: 80,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}