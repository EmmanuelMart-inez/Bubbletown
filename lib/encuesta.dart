import 'package:flutter/material.dart';

class Encuesta extends StatefulWidget {
  @override
  const Encuesta({ Key key }) : super(key: key);
  _EncuestaState createState() => _EncuestaState();
}

class _EncuestaState extends State<Encuesta> {
  
   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              width: double.infinity,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '1 de 4', style: TextStyle(fontSize: 17)
                      ),
                    ),
                    
                    Align(
                      alignment: Alignment.centerRight,
                        child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey[600],
                        width: 100,
                        child: Text(
                          'next', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 45),
                Text(
                  '¿Cuán satisfecho se encuenta con nuestro servicio?',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 45),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  height: 60,
                  color: Colors.grey[800],
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Icon(Icons.check, color: Colors.white, size: 30),
                      ),
                      FlatButton(
                        onPressed: (){},
                        child: Text('Excelente', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  height: 60,
                  color: Colors.grey[500],
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Icon(Icons.check, color: Colors.grey[500], size: 30),
                      ),
                      FlatButton(
                        onPressed: (){},
                        child: Text('Bueno', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  height: 60,
                  color: Colors.grey[500],
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Icon(Icons.check, color:  Colors.grey[500], size: 30),
                      ),
                      FlatButton(
                        onPressed: (){},
                        child: Text('Está bien', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  height: 60,
                  color: Colors.grey[500],
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Icon(Icons.check, color: Colors.grey[500], size: 30),
                      ),
                      FlatButton(
                        onPressed: (){},
                        child: Text('Malo', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  height: 60,
                  color: Colors.grey[500],
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Icon(Icons.check, color: Colors.grey[500], size: 30),
                      ),
                      FlatButton(
                        onPressed: (){},
                        child: Text('Terrible', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:  Container(
          height: 105,
           decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/notif/background_encuesta.png'),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}