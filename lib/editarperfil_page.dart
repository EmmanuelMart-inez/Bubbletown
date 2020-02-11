//import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'dart:io';

import 'package:bubbletown_v1/my_flutter_app_icons.dart';
import 'package:bubbletown_v1/services/participante_service.dart';
import 'package:bubbletown_v1/services/send_image_service.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'catalogo_page.dart';
import 'escanea_page.dart';
import 'home_page.dart';
import 'models/participante_model.dart';
import 'premios_page.dart';

Future<ParticipanteModel> requestParticipante;

class EditarPerfil extends StatefulWidget {
  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  bool isUpdated = false;

  // Image handler
  File _image;

  String urlImg;
  String nombre;
  String passwo;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    requestParticipante = fetchParticipante();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 5),
                    child: Text('Bubble\nTown', style: TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.black, size: 25.0),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, size: 35),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFDADADA),
                            ),
                            child: FlatButton(
                              child: Text(
                                'Guardar',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                // If the form is valid, display a Snackbar.
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('Procesando la información')));
                                if (_formKey.currentState.validate()) {
                                  if (_image != null) {
                                    String imagenNewName = await upload(_image);
                                    print(await patchParticipante(
                                        '{"nombre": "$nombre", "password": "$passwo", "foto": "https://bubbletown.me/download/$imagenNewName"}'));
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('Actualizado con éxito')));
                                        
                                  } else {
                                    print(await patchParticipante(
                                        '{"nombre": "$nombre", "password": "$passwo"}'));
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('Actualizado con éxito')));
                                  }

                                  
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Editar perfil', style: TextStyle(fontSize: 28)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFEBEBEB),
                          ),
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FutureBuilder<ParticipanteModel>(
                                      future: requestParticipante,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            height: 120,
                                            width: 120,
                                            child: _image == null
                                                ? Image.network(
                                                    '${snapshot.data.foto}')
                                                : Image.file(_image),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        return CircularProgressIndicator();
                                      },
                                    ),
                                    Text(
                                      'FOTO DE PERFIL',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onPressed: getImage,
                          ),
                        ),
                        Positioned(
                          child: FlatButton(
                            child: Image.asset(
                              'assets/editarperfil/editarperfil.png',
                              scale: 3.0,
                            ),
                            onPressed: getImage,
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<ParticipanteModel>(
                      future: requestParticipante,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 38.0, vertical: 18),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: Color(0xFFEAF1F7),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.person),
                                      labelText: 'Nombre',
                                    ),
                                    initialValue: '${snapshot.data.nombre}',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Porfavor ingrese algún texto';
                                      }
                                      // Inicialización: En caso de no haber actualizado el perfil y dar click en guardar, enviar el nombre actual
                                      setState(() {
                                        nombre = value;
                                      });
                                      return null;
                                    },
                                    onChanged: (text) {
                                      setState(() {
                                        nombre = text;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    FutureBuilder<ParticipanteModel>(
                      future: requestParticipante,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 38.0, vertical: 18),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: Color(0xFFEAF1F7),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      labelText: 'Contraseña',
                                    ),
                                    initialValue: '${snapshot.data.password}',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Porfavor ingrese algún texto';
                                      }
                                      if (value.length < 6) {
                                        return 'La contraseña debe tener al menos seis caracteres';
                                      }
                                      // Inicialización: En caso de no haber actualizado el perfil y guardar, enviar el nombre actual
                                      setState(() {
                                        passwo = value;
                                      });
                                      return null;
                                    },
                                    onChanged: (text) {
                                      setState(() {
                                        passwo = text;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 105,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 0.7, color: Colors.black),
          )),
          child: BottomNavigationBar(
            iconSize: 40,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/inicio.png',
                  scale: 2,
                ),
                title: Text('Inicio',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/bar.png',
                  scale: 2,
                ),
                title: Text('Tarjeta',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/catalogo.png',
                  scale: 2,
                ),
                title: Text('Catálogo',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/bottombar/premios.png',
                  scale: 2,
                ),
                title: Text('Premios',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
            ],
            onTap: (int index) {
              setState(() {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pago()),
                  );
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Catalogo()),
                  );
                }
                if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Premios()),
                  );
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

String changeImageFormatToUpper(String st) {
  String start;
  String format;
  String newString;
  if (st.substring(st.length - 3).compareTo('PNG') > 0) {
    format = "PNG";
    start = st.substring(0, st.length - 3);
    newString = '$start$format';
    // print(newString);
    return newString;
  } else
    return st;
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
