import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class invitado extends StatefulWidget{
  @override
  invitadoApp createState() => invitadoApp();
}

class invitadoApp extends State<invitado>{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('Usuarios');
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = _usersRef.snapshots();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home invitado'),
          backgroundColor: Color(0x007030A0),

        ),

        body: SingleChildScrollView(
          child: Center(
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

                ]),
          ),
        ),
      ),
    );
  }
}