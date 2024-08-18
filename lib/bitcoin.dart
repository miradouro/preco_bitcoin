import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Bitcoin extends StatefulWidget {
  const Bitcoin({super.key});

  @override
  State<Bitcoin> createState() => _BitcoinState();
}

class _BitcoinState extends State<Bitcoin> {

  double _resultadoDolar = 0.0;
  double _resultadoReal = 0.0;


  void _recuperaPreco() async {
    String url = "https://blockchain.info/ticker";

    http.Response response;
    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    double valorDolar = retorno["USD"]["buy"];
    double valorReal = retorno["BRL"]["buy"];

    setState(() {
      _resultadoDolar = valorDolar;
      _resultadoReal = valorReal;
    });

    print(valorDolar);
    print(valorReal);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Text(
                  "US\$ ${_resultadoDolar.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  "R\$ ${_resultadoReal.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: _recuperaPreco,
                child: const Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
