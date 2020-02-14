import 'package:bubbletown_v1/loginform_page.dart';
import 'package:bubbletown_v1/models/signup_model.dart';
import 'package:bubbletown_v1/services/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:bubbletown_v1/Storage/globals.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bubbletown_v1/services/login_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:bubbletown_v1/Storage/user.dart';
import 'package:bubbletown_v1/models/login_form.dart';
import 'home_page.dart';

LogInFormModel form;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoggedIn = false;

  //////////////////////         Login Google              //////////////////////////////////
  GoogleSignInAccount _currentUser;
  String _contactText;

  @override
  void initState() {
    super.initState();
    form = LogInFormModel();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      if (this.mounted) {
        setState(() {
          _currentUser = account;
        });
        if (_currentUser != null) {
          _handleGetContact();
        }
      }
    });
    // _googleSignIn.signInSilently();

    formStateModel = SignUpFormModel();
    _isfull = false;
    formStateModel.fechaNacimiento = _selectedDateTime;
  }

  Future<void> _handleGetContact() async {
    // _sendTokenToServer(_currentUser., id, social)
    GoogleSignInAuthentication auth = await _currentUser.authentication;
    // _sendTokenToServer(auth.accessToken, auth.idToken, "google");
    // print("${auth.accessToken}\n ${auth.idToken}") ;
    print("${_currentUser.id}   ${_currentUser.email}  ${_currentUser} ");
    final res = await postRegistroSocialNetwork("google", SignUpFormModel(nombre: _currentUser.displayName, foto: _currentUser.photoUrl),
        LogInFormModel(email: _currentUser.email, password: _currentUser.id));
    // if(res.id )
    print(res.id);
    final idParticipante = await setNewTokenData(res.id);
    if (idParticipante != null &&
        idParticipante != "null" &&
        idParticipante.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    return;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  //////////////////////          Login con Facebook           ///////////////////////////////

  Future<void> initiateFacebookLogin() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // TO DO: Checar en la documentación si se devuelve un valor diferente cuando el usuario se registra por primera vez o cuando no se ha registrado,
        // en caso de que no, el API podría implementarlo y entonces dibujar las pantallas con los formularios correspondientes antes de realizar el registro
        onLoginStatusChange(true);
        // _sendTokenToServer(result.accessToken.token);
        // Mandar al API el registro del nuevo participante
        final token = result.accessToken.token;
        // print("TOKEN: ${token}, ${result.accessToken.userId}");

        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=id,short_name,last_name,email,gender,birthday,picture&access_token=${token}');

        // SignUpFormModel form = SignUpFormModel(email: ,nombre: ,sexo: ,paterno: ,password: ,foto: ,fechaNacimiento: );
        // SignUpFormResponseModel a = await postParticipante(form);
        final profile = json.decode(graphResponse.body);
        print(profile);
        // print(result.accessToken.token);
        // print(result.accessToken.userId);
        print(profile["id"]);
        print(profile["email"]);

        //  Obtener Fotografia de perfil
        final graphResponseImage = await http.get(
            'https://graph.facebook.com/v2.12/${profile["id"]}/picture?redirect=0&width=1024&access_token=${token}');

        print('${profile["short_name"]}  ${profile["picture"]["data"]["url"]}  ${profile["last_name"]}  ${profile["gender"]}');
        final res = await postRegistroSocialNetwork(
            "facebook",
            SignUpFormModel(nombre: profile["short_name"], foto: profile["picture"]["data"]["url"], paterno: profile["last_name"], sexo: profile["gender"]),
            LogInFormModel(email: profile["email"], password: profile["id"]));

        final idParticipante = await setNewTokenData(res.id);
        print(res.id);

        // Enviar al API el id del participante para validar usuario
        if (idParticipante != null &&
            idParticipante != "null" &&
            idParticipante.length > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
        // _sendTokenToServer(profile["id"], profile["id"], "facebook");
        // final bubbletownapi_response = await http.get('http://142.93.197.44/participante/facebook_token/${token}');
        // _showLoggedInUI();

        break;
      case FacebookLoginStatus.cancelledByUser:
        // _showCancelledMessage();
        print("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.error:
        // _showErrorOnUI(result.errorMessage);
        print("Ocurrio un error");
        break;
    }
  }

  void onLoginStatusChange(bool isLoggedinn) {
    setState(() {
      this.isLoggedIn = isLoggedinn;
    });
  }

// Create a text controller and use it to retrieve the current value
  // of the TextField.
  SignUpFormModel formStateModel;
  final nombreController = TextEditingController();
  final apelliController = TextEditingController();
  final correoController = TextEditingController();
  final contra1Controller = TextEditingController();
  final contra2Controller = TextEditingController();
  var mostrarcontra = false;
  bool terminosycond = false;
  DateTime _selectedDateTime;
  int _value = 2;
  bool _isfull;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nombreController.dispose();
    apelliController.dispose();
    correoController.dispose();
    contra1Controller.dispose();
    contra2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool check = true;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            padding: EdgeInsets.only(top: 15),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                FlatButton(
                onPressed: _handleSignOut,
                child: Text('Loggout'),
              ),
                Text(
                  'Registro',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: nombreController,
                        obscureText: false,
                        decoration: InputDecoration(
                          // suffixIcon:
                          //     Icon(Icons.check, color: Colors.lightBlue),
                          filled: false,
                          labelText: 'Nombre',
                        ),
                        style: TextStyle(fontSize: 16),
                        maxLength: 10,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (nombre) {
                          formStateModel.nombre = nombreController.text;
                        },
                      ),
                      TextField(
                        controller: apelliController,
                        obscureText: false,
                        decoration: InputDecoration(
                          // suffixIcon:
                          //     Icon(Icons.check, color: Colors.lightBlue),
                          filled: false,
                          labelText: 'Apellido',
                        ),
                        style: TextStyle(fontSize: 16),
                        maxLength: 12,
                        onChanged: (pat) {
                          formStateModel.paterno = apelliController.text;
                        },
                      ),
                      TextFormField(
                        controller: correoController,
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: false,
                          labelText: 'Correo',
                        ),
                        style: TextStyle(fontSize: 16),
                        maxLength: 50,
                        keyboardType: TextInputType.emailAddress,
                        autovalidate: true,
                        validator: validateEmail,
                        onChanged: (email) {
                          formStateModel.email = correoController.text;
                        },
                      ),
                      TextField(
                        controller: contra1Controller,
                        obscureText: mostrarcontra,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.lightBlue,
                            ),
                            onPressed: () {
                              setState(() {
                                mostrarcontra = !mostrarcontra;
                              });
                            },
                          ),
                          filled: false,
                          labelText: 'Contraseña',
                        ),
                        style: TextStyle(fontSize: 16),
                        onChanged: (contra) {
                          formStateModel.password = contra1Controller.text;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Sexo:     ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Wrap(
                            children: <Widget>[
                              ChoiceChip(
                                disabledColor: Colors.white,
                                selectedColor: Colors.blue[100],
                                avatar: Image.asset('assets/registro/man.png',
                                    scale: 20),
                                label: Text('Masculino'),
                                selected: _value == 1,
                                onSelected: (bool selected) {
                                  setState(() {
                                    print('Masculino');
                                    formStateModel.sexo = "Masculino";
                                    _value = selected ? 1 : null;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: Text(
                                  'Femenino',
                                  style: TextStyle(color: Colors.red),
                                ),
                                selectedColor: Colors.pink[100],
                                shadowColor: Colors.pink[100],
                                avatar: Image.asset('assets/registro/woman.png',
                                    scale: 20),
                                selected: _value == 0,
                                onSelected: (bool selected) {
                                  setState(() {
                                    print('femenino');
                                    formStateModel.sexo = "Femenino";
                                    _value = selected ? 0 : null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Fecha de nacimiento: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              color: Colors.grey.shade200,
                              child: IconButton(
                                icon: Icon(
                                  Icons.calendar_today,
                                  size: 28,
                                ),
                                onPressed: _buildCalendar,
                              ),
                            ),
                          ),
                          Text(
                            _selectedDateTime.toString().length > 6
                                ? '${_selectedDateTime.toString().substring(0, _selectedDateTime.toString().length - 12)}'
                                : '',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: terminosycond,
                            onChanged: (bool value) {
                              setState(() {
                                terminosycond = value;
                              });
                            },
                          ),
                          Text('Acepto'),
                          FlatButton(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              'terminos y condiciones',
                              //textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blueAccent),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.0),
                // Text(
                //     '${form.nombre} ${form.paterno} ${form.email} ${form.password} ${form.sexo}  ${form.fechaNacimiento}  ${terminosycond}'),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: MaterialButton(
                    minWidth: 300.0,
                    height: 50.0,
                    onPressed: () async {
                      bool r = _validarCampos(formStateModel);
                      if (r) {
                        formStateModel.foto =
                            "https://www.bubbletown.me/download/bubble.png";
                        SignUpFormResponseModel a =
                            await postParticipante(formStateModel);

                        //  Validar si el usuario ya esta registrado
                        try {
                          print(a.objectId.id);
                        } catch (e) {
                          print(e);
                        }
                        if (a.objectId.id != null) {
                          obid = a.objectId.id;
                          buildShowDialogSuccess(
                              context, "Registro completado", "", "Continuar");
                        } else {
                          // Ok, no se pudo guardar en memoria el participante pero te dejaremos iniciar,
                          // solo que no se guardará en memoria tu _id, lo tendrás global obid
                          // print(obid);
                          buildShowDialogFail(
                              context,
                              "Fallo el registro",
                              "Debes llenar todos los campos y aceptar los terminos y condiciones para continuar",
                              "OK");
                        }
                      } else {
                        buildShowDialogFail(
                            context,
                            "Formulario incompleto",
                            "Debes llenar todos los campos y aceptar los terminos y condiciones para continuar",
                            "OK");
                      }
                    },
                    child: Text(
                      'ACEPTAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      Text(
                        'O',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF415DAE),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: MaterialButton(
                          minWidth: 300.0,
                          height: 50.0,
                          onPressed: () => initiateFacebookLogin(),
                          child: Text(
                            'REGISTRARME CON FACEBOOK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF4184F3),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: MaterialButton(
                          minWidth: 300.0,
                          height: 50.0,
                          onPressed: () => {_handleSignIn()},
                          child: Text(
                            'REGISTRARME CON GOOGLE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value.length > 0)
      return 'Ingrese un correo válido';
    else
      return null;
  }

  _buildCalendar() {
    showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1960),
      lastDate: DateTime(2030),
      locale: Locale('es', 'MX'),
      // builder: (BuildContext context, Widget child) {
      //   return Theme(
      //     data: ThemeData.light(),
      //     child: child,
      //   );
      // },
    ).then(_onDateSelected);
  }

  _onDateSelected(DateTime selected) {
    setState(() {
      _selectedDateTime = selected;
      formStateModel.fechaNacimiento = selected;
    });
  }

  bool _validarCampos(SignUpFormModel form) {
    print(
        '${form.nombre} ${form.paterno} ${form.email} ${form.password} ${form.sexo} ${form.fechaNacimiento}');
    if (form.nombre != null &&
        form.paterno != null &&
        form.email != null &&
        form.password != null &&
        form.sexo != null &&
        form.fechaNacimiento != null &&
        terminosycond)
      return true;
    else
      return false;
    // return '${form.nombre}${form.paterno}${form.email}${form.password}${form.sexo}${form.fechaNacimiento}';
  }

  Future buildShowDialogFail(BuildContext context, String titulo,
      String contenido, String textButton) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("$titulo"),
          content: new Text("$contenido"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("$textButton"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future buildShowDialogSuccess(BuildContext context, String titulo,
      String contenido, String textButton) {
    return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("$titulo"),
          content: new Text("$contenido"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("$textButton"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginForm()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
