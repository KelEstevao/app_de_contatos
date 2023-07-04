import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_de_contatos/telas/menu.dart';

void main() {
  runApp(MaterialApp(
    home: Extra2(),
  ));
}

class Extra2 extends StatefulWidget {
  @override
  _Extra2State createState() => _Extra2State();
}

class _Extra2State extends State<Extra2> {
  String logradouro = "";
  String bairro = "";
  String cidade = "";
  String cep = "";

  Future<void> _buscarCep() async {
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    http.Response response;

    response = await http.get(url);
    print('Resposta' + response.statusCode.toString());
    print('Resposta' + response.body);

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      logradouro = retorno["logradouro"];
      bairro = retorno['bairro'];
      cidade = retorno['localidade'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/menu',
            );
          },
        ),
        title: Text('Busca Cep'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  cep = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'CEP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _buscarCep();
              },
              child: Text('Buscar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                onPrimary: Colors.black,
                minimumSize: Size(120, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rua: $logradouro',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Bairro: $bairro',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Cidade: $cidade',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
