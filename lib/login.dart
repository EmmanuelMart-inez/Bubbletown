import 'package:bubbletown_v1/home_page.dart';
import 'package:bubbletown_v1/loginform_page.dart';
import 'package:bubbletown_v1/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:bubbletown_v1/Storage/user.dart';
import 'package:bubbletown_v1/Storage/globals.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// To read data, use the appropriate getter method provided by the SharedPreferences class.
// For each setter there is a corresponding getter.
// For example, you can use the getInt, getBool, and getString methods.

class LoginPage extends StatefulWidget {
  @override
  //static String tag = 'login-page';
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isThereToken = false;
  // int page = 0;
  int colorPaletteIndex = 0;
  final controller = PageController(viewportFraction: 0.5, initialPage: 0
      // initialPage: 4
      );

  @override
  void initState() {
    super.initState();

    // print(obid);
    // print(mythem)
    getColorPalette();
    asyncTokenValidation();
  }

  void asyncTokenValidation() async {
    final token = await readTokenData();
    if (token != null && token != 0) {
      setState(() {
        _isThereToken = true;
        print("El token existe en memoria: $token");
      });
    }
  }

  void loggoutUserPreferences() async {
    final prefs = await SharedPreferences.getInstance()
        .catchError((onError) => print("$onError"));
    try {
      final result = await prefs.remove('bubbletownToken');
      if (result)
        print("Se logró eliminar el token de acceso (_id) participante");
    } catch (e) {
      print(e);
    }
  }

  // Get current color palette
  void getColorPalette() async {
    final pIndex = await readTheme('indexPallete');
    if (pIndex == '-1')
      setState(() {
        colorPaletteIndex = 0;
      });
    else
      setState(() {
        colorPaletteIndex = int.parse(pIndex);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse("0xFF${colorPalette[colorPaletteIndex][3]}")),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 120.0),
            // SizedBox(height: 150.0),
            Text(
              'Bubbletown',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35.0,
              ),
            ),
            SizedBox(height: 35.0),
            Image.asset('assets/logoBubbletown.png', width: 190,),
            SizedBox(height: 35.0),
            // SizedBox(height: 45.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[600],
                border: Border.all(width: 3.0, color: Colors.grey[600]),
                // border: Border.all(width: 3.0, color: Colors.grey[600]),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: MaterialButton(
                minWidth: 240.0,
                height: 42.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: MaterialButton(
                minWidth: 240.0,
                height: 42.0,
                onPressed: () {
                  if (_isThereToken)
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => LoginForm()),
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  else
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginForm()),
                    );
                },
                child: Text(
                  'Ya tengo una cuenta',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 36,
                      ),
                      // Text(page.toString()),
                      SizedBox(
                        height: 30,
                        child: PageView(
                            reverse: false,
                            onPageChanged: (int currentPage) => {
                                  setState(() {
                                    colorPaletteIndex = currentPage;
                                    // page = currentPage;
                                    setPreference(
                                        'indexPallete', currentPage.toString());
                                  })
                                },
                            controller: controller,
                            children: List.generate(
                                colorPalette.length,
                                (int index) => Card(
                                      key: PageStorageKey<String>(
                                          index.toString()),
                                      // shape: RoundedRectangleBorder(
                                      //     borderRadius:
                                      //         BorderRadius.circular(16)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                color: Color(int.parse(
                                                    "0xFF${colorPalette[index][0]}")),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                color: Color(int.parse(
                                                    "0xFF${colorPalette[index][1]}")),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                color: Color(int.parse(
                                                    "0xFF${colorPalette[index][2]}")),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                color: Color(int.parse(
                                                    "0xFF${colorPalette[index][3]}")),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 16, bottom: 8),
                      //   child: Text('Worm'),
                      // ),
                      Container(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: colorPalette.length,
                          effect: WormEffect(),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 16, bottom: 8),
                      //   child: Text("Slide"),
                      // ),
                      // Container(
                      //   child: SmoothPageIndicator(
                      //     controller: controller,
                      //     count: 6,
                      //     effect: SlideEffect(
                      //         spacing: 8.0,
                      //         radius: 4.0,
                      //         dotWidth: 24.0,
                      //         dotHeight: 16.0,
                      //         dotColor: Colors.grey,
                      //         paintStyle: PaintingStyle.stroke,
                      //         strokeWidth: 2,
                      //         activeDotColor: Colors.indigo),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 16, bottom: 8),
                      //   child: Text("Scrolling Dots "),
                      // ),
                      // SmoothPageIndicator(
                      //     controller: controller,
                      //     count: 6,
                      //     effect: ScrollingDotsEffect(
                      //       activeStrokeWidth: 2.6,
                      //       activeDotScale: .4,
                      //       radius: 8,
                      //       spacing: 10,
                      //     )),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(width: 3.0),
            //     borderRadius: BorderRadius.all(Radius.circular(30.0)),
            //   ),
            //   child: MaterialButton(
            //     minWidth: 240.0,
            //     height: 42.0,
            //     onPressed: () {
            //       loggoutUserPreferences();
            //       setState(() {
            //         _isThereToken = false;
            //       });
            //     },
            //     child: Text(
            //       'Eliminar (participante_id) token de userPreferences',
            //       style: TextStyle(color: Colors.black),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Color(int.parse("0xFF${colorPalette[colorPaletteIndex][1]}")),
        height: 60.0,
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
    );
  }
}
