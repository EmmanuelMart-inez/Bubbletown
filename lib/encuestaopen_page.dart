import 'package:flutter/material.dart';

class EncuestaAbierta extends StatefulWidget {
  @override
  const EncuestaAbierta({ Key key }) : super(key: key);
  _EncuestaAbiertaState createState() => _EncuestaAbiertaState();
}

class _EncuestaAbiertaState extends State<EncuestaAbierta> {
  
   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false, // Used for removing back buttoon "<". 
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
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){},
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.grey[600],
                            width: 100,
                            child: Text(
                              'next', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    '¿Qué es lo que más le gusta de nuestro producto o servicio?',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextField(
                    maxLines: 20,
                    minLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.spellcheck),
                    ),
                  ),
                )
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