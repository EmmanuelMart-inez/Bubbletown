import 'package:bubbletown_v1/loginform_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                Text(
                  'Sign up',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 14),
                Container(
                  height: 320.0,
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            suffixIcon:
                                Icon(Icons.check, color: Colors.lightBlue),
                            filled: false,
                            labelText: 'Nombre',
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 14),
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            suffixIcon:
                                Icon(Icons.check, color: Colors.lightBlue),
                            filled: false,
                            labelText: 'Apellido',
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 14),
                      Expanded(
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            suffixIcon:
                                Icon(Icons.check, color: Colors.lightBlue),
                            filled: false,
                            labelText: 'Correo',
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 14),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye,
                                color: Colors.lightBlue),
                            filled: false,
                            labelText: 'Contraseña',
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: check,
                            onChanged: (bool value) {
                              setState(() {});
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
                      MaterialPageRoute(builder: (context) => LoginForm()),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF4184F3),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                          'CONTINUE WITH GOOGLE',
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
}
