import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
      ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.orange),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Formulario"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: MyAppN(),
      ),
    );
  }
}

class MyAppN extends StatefulWidget {
  @override
  _MyAppNState createState() => _MyAppNState();
}

class _MyAppNState extends State<MyAppN> {
  final _nombre = TextEditingController();
  final _correo = TextEditingController();
  final _contra = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  SharedPreferences entrada;
  bool usuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sesion();
  }

  void sesion() async {
     entrada = await SharedPreferences.getInstance();
    usuario = entrada.getBool('carga') ?? false;
    print(usuario);

    if (usuario == false) {
      Navigator.push(
        context, new MaterialPageRoute(
          builder: (context) => PantallaSesion()
      ),
      );
    }
  }

  @override
  void dispose() {
    _nombre.dispose();
    _correo.dispose();
    _contra.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child:
                    Image.network("https://cdn.iconscout.com/icon/free/png-256/avatar-373-456325.png", height: 230),

                   // Image.network("https://cdn0.iconfinder.com/data/icons/social-media-network-4/48/male_avatar-512.png", height: 240),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
                  child: TextFormField(
  //                  validator: (nombre) =>
//                    nombre.isEmpty?"Llena el campo, por favor": null,
                    controller: _nombre,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle, color: Colors.lightGreenAccent),
                      border: OutlineInputBorder(),
                      labelText: 'Nombre: ',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
    //                validator: (correo) =>!correo.contains("@")?"Prueba con una direccion valida"
      //                  : null,
                    controller: _correo,
                    decoration: InputDecoration(
                      icon: Icon(Icons.alternate_email, color: Colors.lightGreenAccent),
                      border: OutlineInputBorder(),
                      labelText: 'Correo: ',
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    cursorColor: Colors.lightGreenAccent,
                    cursorRadius: Radius.circular(16.0),
                    cursorWidth: 16.0,
                    obscureText: true,
        //            validator: (contra) =>contra.isEmpty?"Llena el campo, por favor": null,
                    controller: _contra,
                    decoration: InputDecoration(
                      icon: Icon(Icons.security, color: Colors.lightGreenAccent),
                      border: OutlineInputBorder(),
                      labelText: 'Contrasena: ',
                    ),
                  ),
                ),

                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.indigo,
                  onPressed: () {
                    String nombre = _nombre.text;
                    String correo = _correo.text;
                    String contra = _contra.text;

                   if(!correo.contains("@")){
                      showInSnackBar("Inserta una direccion de correo valida.");
                    }
                    else if (nombre != '' && contra != '' && correo != '') {
                      entrada.setBool('carga', false);
                      entrada.setString('nombre', nombre);
                      entrada.setString('correo', correo);


                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => PantallaSesion()));
                    }
                    else {
                      showInSnackBar("Heey, no te olvides de llenar el formulario.");
                      print("Falta llenar el formulario.");
                    }
                  },
                  child: Text("Entrar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
}