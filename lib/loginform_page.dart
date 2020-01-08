import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
