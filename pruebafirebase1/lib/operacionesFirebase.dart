import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OpFirebase extends StatefulWidget {
  OpFirebase({Key key}) : super(key: key);

  @override
  _OpFirebaseState createState() => _OpFirebaseState();
}

class _OpFirebaseState extends State<OpFirebase> {
  final firebaseInstance = FirebaseFirestore.instance;

  void agregarFirebase() {
    firebaseInstance.collection('personas').add(
        {'Nombre': 'Yessica', 'Edad': '19', 'Pais': 'Mexico', 'Activo': true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Operaciones Firestore')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  agregarFirebase();
                },
                child: Text('Agregar', style: TextStyle(fontSize: 20.0)))
          ],
        ),
      ),
    );
  }
}
