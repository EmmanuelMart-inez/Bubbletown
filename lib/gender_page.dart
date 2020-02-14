import 'package:bubbletown_v1/home_page.dart';
import 'package:bubbletown_v1/login.dart';
import 'package:bubbletown_v1/services/participante_service.dart';
import 'package:flutter/material.dart';

bool selected = false;

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !selected
            ? Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    // Expanded(child: Container(color: Colors.white)),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "Ya casi está lista tu cuenta!",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "  Escoge tu género  ",
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                    GenderCard(gender: 'male', color: '0xFF42C8FB'),
                    GenderCard(
                      gender: 'female',
                      color: '0xFFFF7979',
                    ),
                    SizedBox(
                      height: 90,
                    )
                  ],
                ),
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amberAccent,
                  ),
                ),
              ),
      ),
    );
  }
}

class GenderCard extends StatefulWidget {
  const GenderCard({Key key, this.gender, this.color}) : super(key: key);
  final gender;
  final color;

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  int statusCode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: FlatButton(
          onPressed: () async {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Procesando la información')));
            if (widget.gender == 'male') {
              statusCode = await patchParticipante('{"sexo": "Masculino"}');
            } else {
              statusCode = await patchParticipante('{"sexo": "Femenino"}');
            }
            if (statusCode == 200) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpiredTokenWidget()),
              );
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(int.parse('${widget.color}')), width: 5),
              borderRadius: BorderRadius.all(Radius.circular(
                      80.0) //                 <--- border radius here
                  ),
            ),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Image.asset('assets/registro/${widget.gender}.png'),
              ),
            ),
          ),
        ));
  }
}

class ExpiredTokenWidget extends StatelessWidget {
  const ExpiredTokenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDCCAC7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              width: double.infinity,
              child: Opacity(opacity: 0.3, child: DefaultHeaderWidget()),
            ),
          ),
        ),
        body: Container(
          color: Color(0xFFDCCAC7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  title: Container(
                    color: Color(0xFFEC5D57),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Error de conexión'),
                        IconButton(
                          iconSize: 20,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.all(0),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.zero,
                  contentTextStyle:
                      TextStyle(fontSize: 10, color: Colors.black, height: 1.3),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.access_time,
                          color: Color(0xFFDD6F6B),
                          size: 25,
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 170,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Text(
                                'No se pudo enviar el formulario, por favor revise su conexión a internet o intentente más tarde',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Text(
                              'Serás redirigido a la pagina de inicio de sesión',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                      color: Color(0xFFEC5D57),
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
