import 'package:flutter/material.dart';
import 'Storage/globals.dart';

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
                "$apiURLImages/fb_meencanta.gif",
                width: 150,
              ),
              Image.network(
                "$apiURLImages/fb_meentristece_1.gif",
                width: 150,
              ),
              Image.network(
                "$apiURLImages/fb_meenoja.gif",
                width: 150,
              ),
              Image.network(
                "$apiURLImages/fb_megusta.gif",
                width: 150,
              ),
              Image.network(
                "$apiURLImages/fb_medivierte.gif",
                width: 150,
              ),
              Image.network(
                "$apiURLImages/fb_mesorprende_1.gif",
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
