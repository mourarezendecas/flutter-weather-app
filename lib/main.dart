import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

const request =
    "https://api.openweathermap.org/data/2.5/weather?lat=-16.6869&lon=-49.2648&appid=df90da07a78a2079cace351bdf00e4dc&units=metric";

void main() => runApp(MaterialApp(
      title: 'Weather App',
      home: Home(),
    ));

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var descp;
  var atual;
  var humidade;
  var vento;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(request));
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.descp = result['weather'][0]['description'];
      this.atual = result['weather'][0]['main'];
      this.humidade = result['main']['humidity'];
      this.vento = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Temperatura atual',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    atual != null ? atual.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperatura"),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Clima"),
                    trailing:
                        Text(descp != null ? descp.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidade"),
                    trailing: Text(humidade != null
                        ? humidade.toString() + "\u00B0"
                        : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Velocidade de vento"),
                    trailing:
                        Text(vento != null ? vento.toString() : "Loading"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
