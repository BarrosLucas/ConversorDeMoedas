import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart' as async;
import 'dart:async';
import 'package:convert/convert.dart';

const api_link = "https://api.hgbrasil.com/finance?format=json&key=0dd233b6";

void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(api_link);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Contador de Moedas \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                "Carregando Dados...",
                style: TextStyle(color: Colors.amber, fontSize: 25),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Falha ao carregar Dados",
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                  textAlign: TextAlign.center,
                ));
              } else {
                return Container(
                  color: Colors.green,
                );
              }
          }
        },
      ),
    );
  }
}
