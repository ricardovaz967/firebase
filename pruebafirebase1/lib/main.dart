import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'operacionesFirebase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class User {
  String nombre;
  String profesion;

  User({this.nombre, this.profesion});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: OpFirebase(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> _listaUsers;
  TextStyle estilosTexto = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepOrange);
  Future<List<User>> _obtenerUsiarios() async {
    List<User> users = [];
    CollectionReference crUsuario =
        FirebaseFirestore.instance.collection("usuario");
    QuerySnapshot usuarios = await crUsuario.get();

    if (usuarios.docs.length != 0) {
      for (var doc in usuarios.docs) {
        users.add(User(nombre: doc['nombre'], profesion: doc['profesion']));
      }
    }

    return users;
  }

  @override
  void initState() {
    super.initState();
    _listaUsers = _obtenerUsiarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: _listaUsers,
          initialData: List<User>.empty(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _listadoUsers(snapshot.data),
              );
            } else if (snapshot.error) {
              print(snapshot.error);
              print('Error');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listadoUsers(List<User> data) {
    List<Widget> userList = [];
    for (var user in data) {
      userList.add(Card(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nombre: ' + user.nombre,
              style: estilosTexto,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Profesion: ' + user.profesion,
              style: estilosTexto,
            ),
          )
        ],
      )));
    }
    return userList;
  }
}
