import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PantallaSesion(
      ),
    );
  }
}

class PantallaSesion extends StatefulWidget {
  @override
  PantallaSesionState createState() => PantallaSesionState();
}

class PantallaSesionState extends State<PantallaSesion> {
  SharedPreferences entrada;
  String nombre;
  String correo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    entrada = await SharedPreferences.getInstance();
    setState(() {
      nombre = entrada.getString('nombre');
      correo = entrada.getString('correo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child:
                Image.network("https://bepensahosting.com/cepeca%20chafa/media/bienvenido.png", height: 250),

                // Image.network("https://cdn0.iconfinder.com/data/icons/social-media-network-4/48/male_avatar-512.png", height: 240),
              ),
            ),

            Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hola $nombre, es un gusto tenerte aqui de nuevo, tu cuenta de correo es $correo.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                onPressed: () {
                  entrada.setBool('carga', true);
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => MyAppN()));
                },
                child: Text('Cerrar Sesion'),
              ),
            )
          ],
        ),
      ),
    );
  }
}