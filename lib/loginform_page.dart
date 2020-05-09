import 'dart:async';
import 'dart:convert';
import 'package:bubbletown_v1/Storage/user.dart';
import 'package:bubbletown_v1/Storage/globals.dart';
import 'package:bubbletown_v1/models/login_form.dart';
import 'package:bubbletown_v1/models/signup_model.dart';
import 'package:bubbletown_v1/services/login_service.dart';
import 'package:bubbletown_v1/services/signup_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'Storage/globals.dart';

LogInFormModel form;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
  }

  Future<void> _handleGetContact() async {
    // _sendTokenToServer(_currentUser., id, social)
    GoogleSignInAuthentication auth = await _currentUser.authentication;
    // _sendTokenToServer(auth.accessToken, auth.idToken, "google");
    // print("${auth.accessToken}\n ${auth.idToken}") ;
    print("${_currentUser.id}   ${_currentUser.email}   ");
    final res = await postLoginSocialNetwork("google",
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
            'https://graph.facebook.com/v2.12/me?fields=id,short_name,last_name,email,gender,picture&access_token=${token}');

        // SignUpFormModel form = SignUpFormModel(email: ,nombre: ,sexo: ,paterno: ,password: ,foto: ,fechaNacimiento: );
        // SignUpFormResponseModel a = await postParticipante(form);
        final profile = json.decode(graphResponse.body);
        print(profile);
        // print(result.accessToken.token);
        // print(result.accessToken.userId);
        print(profile["id"]);
        print(profile["email"]);
        final res = await postLoginSocialNetwork("facebook",
            LogInFormModel(email: profile["email"], password: profile["id"]));

        final idParticipante = await setNewTokenData(res.id);
        print(res.id);

        final graphResponseImage = await http.get(
            'https://graph.facebook.com/v2.12/${profile["id"]}/picture?redirect=0&width=1024&access_token=${token}');

        // Enviar al API el id del participante para validar usuario
        if (idParticipante != null &&
            idParticipante != "null" &&
            idParticipante.length > 0) {
          _handleSignOut();
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

  Future<String> _sendTokenToServer(
      String token, String id, String social) async {
    String url = '$apiURL/autenticacion/$social';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonformdata = "{'token': $token, 'id': $id}";
    // make POST request
    try {
      final response =
          await http.post(url, headers: headers, body: jsonformdata);
      // check the status code for the result
      if (response.statusCode == 200) {
        print("200 en _sendTokenToServer");
        print(response.body);
        return response.body;
      } else {
        print("No se pudo enviar token");
        return "No se pudo efectuar el registro o inicio de sesión, intente de otra forma";
      }
    } catch (e) {
      print(e);
    }
    return "No se pudo efectuar esta acción, intente más tarde";
  }

  //////////////////////          Login con Facebook      end     ///////////////////////////////

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 25.0),
              // TODO: Actualizar el estado de este mensaje
              // Bienvenido de regreso cuando ya no tiene el _id almacenado, es decir, solo va a iniciar sesión, no ha realizado registro
              // Iniciar sesión cuando se acaba de registrar
              Text('Bienvenido de regreso',
                  style: Theme.of(context).textTheme.title.copyWith(
                        fontSize: 22.0,
                      )),
              SizedBox(height: 45.0),
              Container(
                height: 140.0,
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: 'Email address',
                        ),
                        onChanged: (email) {
                          setState(() {
                            form.email = email;
                          });
                        },
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: 'Password',
                        ),
                        onChanged: (passw) {
                          setState(() {
                            form.password = passw;
                          });
                        },
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                        //padding: EdgeInsets.only(right: 200),
                        child: Text(
                          'Olvidaste tu contraseña?',
                          //textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueAccent),
                        ),
                        onPressed: () {
                          buildShowDialog(
                              context,
                              "Recuperación de contraseña",
                              "Acuda con un empleado para que pueda recuperar su contraseña. Gracias.",
                              "Entendido");
                        }),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: MaterialButton(
                  minWidth: 300.0,
                  height: 50.0,
                  onPressed: () async {
                    bool r = _validarCampos(form);
                    // Si el formulario está completo
                    if (r) {
                      LogInFormResponseModel a = await postLogin(form);
                      //  Validar si el usuario ya esta registrado
                      // Si se encontró un participante
                      print(a.id);
                      if (a.id != "null" && a.id != null) {
                        try {
                          final idp = await setNewTokenData(a.id);
                          print("Id en memoria: $idp, response id : ${a.id}");
                        } catch (e) {
                          print(e);
                        }
                        if (a.id != null) {
                          obid = a.id;
                          print("Id en memoria: $obid");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          // Ok, no se pudo guardar en memoria el participante pero te dejaremos iniciar,
                          // solo que no se guardará en memoria tu _id, lo tendrás global obid
                          // print(obid);
                          buildShowDialogFail(
                              context,
                              "Fallo el registro",
                              "No se pudo almacenar el registro del participante, intenta con otro teléfono",
                              "OK");
                        }
                      } else {
                        buildShowDialogFail(
                            context,
                            "Fallo la autenticación",
                            "El correo o la contraseña no corresponden con un participante de este programa de lealtad",
                            "OK");
                      }
                    } else {
                      buildShowDialogFail(
                          context,
                          "Formulario incompleto",
                          "Por favor llene el todo el formulario, ingresando su fecha de cumpleaños, sexo y acepte los términos y condiciones",
                          "OK");
                    }
                  },
                  child: Text(
                    'INICIAR SESIÓN',
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
                          'CONTINUAR CON FACEBOOK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    // _buildBody(),
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
                          'CONTINUAR CON GOOGLE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFF4184F3),
                    //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //   ),
                    //   child: MaterialButton(
                    //     minWidth: 300.0,
                    //     height: 50.0,
                    //     onPressed: _handleSignOut,
                    //                             child: Text(
                    //                               'loggout',
                    //                               style: TextStyle(
                    //                                 color: Colors.white,
                    //                                 fontSize: 16,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  bool _validarCampos(LogInFormModel form) {
    print("${form.email} ${form.password} ");
    if (form.email != null && form.password != null)
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
      barrierDismissible: false,
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

  Future buildShowDialog(BuildContext context, String titulo, String contenido,
      String textButton) {
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
}
