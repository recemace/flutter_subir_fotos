import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:subir_fotos/src/utils/constants.dart' as Constants;

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  File file;
  String lnk_image_server = '';
  String url = '';
  String boton_subir = 'Subir imagen al servidor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _choose,
                child: Text('Toma una foto'),
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: _upload,
                child: Text(boton_subir),
              )
            ],
          ),
          if (lnk_image_server != '')
            RaisedButton(
              onPressed: () {
                url = Constants.URL_SERVER + lnk_image_server + '.jpg';
                launch(url);
              },
              child: new Text('Ver foto: ' + lnk_image_server + '.jpg'),
            ),
          if (file == null) Text('No hay foto') else Image.file(file)
        ],
      ),
    );
  }

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
    lnk_image_server = '';
    setState(() {});
  }

  void _upload() {
    if (file == null) return;
    boton_subir = 'Subiendo...';
    setState(() {});
    final String subir_imagen = Constants.URL_SERVER + 'fotos.php';
    String base64Image = base64Encode(file.readAsBytesSync());
    http.post(subir_imagen,
        body: {"image": 'data:image/jpeg;base64,' + base64Image}).then((res) {
      lnk_image_server = res.body;
      boton_subir = 'Subir imagen al servidor';
      setState(() {});
    }).catchError((err) {
      print(err);
    });
  }
}
