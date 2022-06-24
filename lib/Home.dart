import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Home extends StatefulWidget {
  const Home ({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "Resultado: ";
  TextEditingController _cepController = TextEditingController();

   _recuperarCep() async{
    String url = "https://viacep.com.br/ws/${_cepController.text}/json/";
    http.Response _response;
    _response = await http.get(url);
    //print("Resposta: " + _response.statusCode.toString());
    //print("Body: " + _response.body);
     Map<String,dynamic> retorno = jsonDecode(_response.body);
     String logradouro = retorno["logradouro"];
     String complemento = retorno["complemento"];
     String bairro = retorno["bairro"];
     String localidade = retorno["localidade"];
     setState((){
       _resultado = "${logradouro},${complemento},${bairro},${localidade}";
     });
     limparTexto();
   }

   void limparTexto(){
     _cepController.text = "";
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscador de Ceps")),
      body: SingleChildScrollView(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 160),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SizedBox( width: 300,child: TextField()),
                    SizedBox(width: 300,child:  Padding(padding: EdgeInsets.only(bottom: 40),child: TextField(obscureText: false, decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'CEP', ),controller: _cepController,))),
                    RaisedButton(onPressed: () => _recuperarCep(), child: Text("Pesquisar")),
                    Container(
                        margin: EdgeInsets.all(40),
                        child: Padding(padding: EdgeInsets.only(top: 40),child: Text(_resultado))
                    )
                  ]
              ),
            ),
          ],
        ),
      )
    );
  }
}
