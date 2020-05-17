import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class HomePage extends StatefulWidget{

  final HomePage todo;
  HomePage({this.todo});


  @override
  MyHomePageState createState() => MyHomePageState();
}


class MyHomePageState extends State<HomePage> {
  String _contador = "";

  @override
  void initState() {
    super.initState;
    _increaseDatafromSharePref();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(_contador, style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

// GUARDAR INFO
  Future<int> _obtenerDatafromSharedPref() async {
    final shareprefs = await SharedPreferences.getInstance();
    var numero = shareprefs.getInt('numeroInicio') ?? 0; // Ve si existe o no, en caso de que no lo convierte en 0
    print(numero);
    return numero;
  }

// INCREMENTAR VALOR ALMACENADO
  Future<void> _increaseDatafromSharePref() async {
    final shareprefs = await SharedPreferences.getInstance();
    int ultimonumero = await _obtenerDatafromSharedPref();
    int numerosumado = ++ultimonumero;
    await shareprefs.setInt("numeroInicio", numerosumado);
    setState(() {
      Card(
        elevation: 3.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(""))),
            ),
            Text(
            //  HomePage(todo: _nombre),
              "Funciona",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
      _contador = 'La aplicacion ha sido iniciada $numerosumado veces.';
    });
  }
}
