import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoggedIn = false;
  GoogleSignInAccount _currentUser;
  String _contactText;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  // Future<void> initiateGoogleSignIn() async{
  //   _googleSignIn = GoogleSignIn(
  //       scopes: [
  //         'profile',
  //         'email'
  //       ]
  //   );
    
  //   try{ 
  //     await _googleSignIn.signIn();
  //   }
  //   catch(e){
  //     print(e);
  //   }
  // }

  // Future<void> _handleSignOut() async{
  //   _googleSignIn.disconnect();
  // }

  Future<void> initiateFacebookLogin() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:

        // TODO: Checar en la documentación si se devuelve un valor diferente cuando el usuario se registra por primera vez o cuando no se ha registrado,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn = false;
     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
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
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          const Text("Signed in successfully."),
          Text(_contactText ?? ''),
          RaisedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
          RaisedButton(
            child: const Text('REFRESH'),
            onPressed: _handleGetContact,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          RaisedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  void onLoginStatusChange(bool isLoggedinn) {
    setState(() {
      this.isLoggedIn = isLoggedinn;
    });
  }

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
              Text('Welcome back',
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
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: 'Email address',
                        ),
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
                          'Forgot password?',
                          //textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueAccent),
                        ),
                        onPressed: () {}),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text(
                    'LOG IN',
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
                      'OR',
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
                          'CONTINUE WITH FACEBOOK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    _buildBody(),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF4184F3),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: MaterialButton(
                        minWidth: 300.0,
                        height: 50.0,
                        onPressed: () => _handleSignIn(),
                        child: Text(
                          'CONTINUE WITH GOOGLE',
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
                        
                          
}
