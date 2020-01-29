import 'dart:async';
import 'dart:convert';
import 'package:bubbletown_v1/Storage/user.dart';
import 'package:bubbletown_v1/Storage/globals.dart';
import 'package:bubbletown_v1/models/login_form.dart';
import 'package:bubbletown_v1/services/login_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

LogInFormModel form;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    // 'profile',
    'email',
    // 'https://www.googleapis.com/auth/user.birthday.read',
    // 'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoggedIn = false;
  String _contactText;

  //////////////////////         Login Google              //////////////////////////////////
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    form = LogInFormModel();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        // _handleGetContact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
    // _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
      '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  // Widget _buildBody() {
  //   if (_currentUser != null) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         ListTile(
  //           leading: GoogleUserCircleAvatar(
  //             identity: _currentUser,
  //           ),
  //           title: Text(_currentUser.displayName ?? ''),
  //           subtitle: Text(_currentUser.email ?? ''),
  //         ),
  //         const Text("Signed in successfully."),
  //         Text(_contactText ?? ''),
  //         RaisedButton(
  //           child: const Text('SIGN OUT'),
  //           onPressed: _handleSignOut,
  //         ),
  //         RaisedButton(
  //           child: const Text('REFRESH'),
  //           onPressed: _handleGetContact,
  //         ),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         const Text("You are not currently signed in."),
  //         RaisedButton(
  //           child: const Text('SIGN IN'),
  //           onPressed: _handleSignIn,
  //         ),
  //       ],
  //     );
  //   }
  // }

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
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        print(profile);
        // final bubbletownapi_response = await http.get('http://142.93.197.44/participante/facebook_token/${token}');
        // _showLoggedInUI();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
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
                    if (r) {
                      LogInFormResponseModel a = await postLogin(form);
                      //  Validar si el usuario ya esta registrado
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
        bottomSheet: Container(
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: crosAxisAlignment.start,
                children: <Widget>[
                  Row(
                    //Icon(Icons.my_location, color: Colors.grey[500]),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.my_location, color: Colors.grey[500]),
                      Text(' Calle Marsella 14, Juárez, \n'
                          '06600 Col Juárez, CDMX')
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    //Icon(Icons.my_location, color: Colors.grey[500]),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer, color: Colors.grey[500]),
                      Text('Abierto')
                    ],
                  ),
                  Row(
                    //Icon(Icons.my_location, color: Colors.grey[500]),
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('10:00am - 11:00 pm')],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validarCampos(LogInFormModel form) {
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
