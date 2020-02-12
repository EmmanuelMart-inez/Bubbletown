import 'package:bubbletown_v1/loginform_page.dart';
import 'package:bubbletown_v1/models/signup_model.dart';
import 'package:bubbletown_v1/services/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:bubbletown_v1/Storage/globals.dart';

import 'home_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
// Create a text controller and use it to retrieve the current value
  // of the TextField.
  SignUpFormModel form;
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
  void initState() {
    super.initState();
    form = SignUpFormModel();
    // form.nombre = nombreController.text;
    // form.paterno = apelliController.text;
    // form.email = correoController.text;
    // form.password = contra1Controller.text;
    // form.nombre = nombreController.text;
    _isfull = false;
    form.fechaNacimiento = _selectedDateTime;
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
                Text(
                  'Registro',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 24),
                Container(
                  height: 280.0,
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
                          form.nombre = nombreController.text;
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
                          form.paterno = apelliController.text;
                        },
                      ),
                      TextFormField(
                        controller: correoController,
                        obscureText: false,
                        decoration: InputDecoration(
                          // suffixIcon:
                          //     Icon(Icons.check, color: Colors.lightBlue),
                          // filled: false,
                          labelText: 'Correo',
                        ),
                        style: TextStyle(fontSize: 16),
                        maxLength: 50,
                        keyboardType: TextInputType.emailAddress,
                        // autovalidate: true,
                        // validator: validateEmail,
                        onChanged: (email) {
                          form.email = correoController.text;
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
                          form.password = contra1Controller.text;
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
                                    form.sexo = "Masculino";
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
                                    form.sexo = "Femenino";
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
                          IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              size: 28,
                            ),
                            onPressed: _buildCalendar,
                          ),
                          Text(
                            '${_selectedDateTime.toString().substring(0, 10)}',
                            style: TextStyle(
                              fontSize: 14,
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
                SizedBox(height: 15.0),
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
                      bool r = _validarCampos(form);
                      if (r) {
                        form.foto =
                            "https://estaticos.muyinteresante.es/media/cache/760x570_thumb/uploads/images/article/5536592a70a1ae8d775df846/dia-del-mono.jpg";
                        SignUpFormResponseModel a =
                            await postParticipante(form);

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
                          onPressed: () {},
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
                          onPressed: () {},
                          // () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HomePage()),
                          //   );
                          // },
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

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
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
      form.fechaNacimiento = selected;
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

// class GenderOptions extends StatefulWidget {
//   GenderOptions({this.sexo});
//   String sexo;
//   @override
//   _GenderOptionsState createState() => _GenderOptionsState();
// }

// class _GenderOptionsState extends State<GenderOptions> {
//   int _value = 2;

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: <Widget>[
//         ChoiceChip(
//           disabledColor: Colors.white,
//           selectedColor: Colors.blue[100],
//           avatar: Image.asset('assets/registro/man.png', scale: 20),
//           label: Text('Masculino'),
//           selected: _value == 1,
//           onSelected: (bool selected) {
//             setState(() {
//               print('Masculino');
//               widget.sexo = "Masculino";
//               _value = selected ? 1 : null;
//             });
//           },
//         ),
//         ChoiceChip(
//           label: Text(
//             'Femenino',
//             style: TextStyle(color: Colors.red),
//           ),
//           selectedColor: Colors.pink[100],
//           shadowColor: Colors.pink[100],
//           avatar: Image.asset('assets/registro/woman.png', scale: 20),
//           selected: _value == 0,
//           onSelected: (bool selected) {
//             setState(() {
//               print('femenino');
//               widget.sexo = "Femenino";
//               _value = selected ? 0 : null;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
