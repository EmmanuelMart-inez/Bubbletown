import 'package:flutter/material.dart';

class FacebookReactions extends StatefulWidget {
  @override
  _FacebookReactionsState createState() => _FacebookReactionsState();
}

class _FacebookReactionsState extends State<FacebookReactions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Facebook reacciones'),
        ),
        body: Container(
          child: Wrap(
            children: <Widget>[
              Image.network(
                "https://bubbletown.me/download/fb_meencanta.gif",
                width: 150,
              ),
              Image.network(
                "https://bubbletown.me/download/fb_meentristece_1.gif",
                width: 150,
              ),
              Image.network(
                "https://bubbletown.me/download/fb_meenoja.gif",
                width: 150,
              ),
              Image.network(
                "https://bubbletown.me/download/fb_megusta.gif",
                width: 150,
              ),
              Image.network(
                "https://bubbletown.me/download/fb_medivierte.gif",
                width: 150,
              ),
              Image.network(
                "https://bubbletown.me/download/fb_mesorprende_1.gif",
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
