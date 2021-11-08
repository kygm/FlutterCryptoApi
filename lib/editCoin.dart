// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class EditCoin extends StatefulWidget {
  final String id, coinName, coinTicker;

  final CryptoApi api = CryptoApi();

  EditCoin(this.id, this.coinName, this.coinTicker);

  @override
  _EditCoinState createState() => _EditCoinState(id, coinName, coinTicker);
}

class _EditCoinState extends State<EditCoin> {
  final String id, coinName, coinTicker;

  _EditCoinState(this.id, this.coinName, this.coinTicker);

  void _changeCoinPrice(id, price) {
    setState(() {
      widget.api.editCoin(id, double.parse(price));
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.coinTicker,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Enter a new price for " + widget.coinName,
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _changeCoinPrice(widget.id, priceController.text),
                          },
                      child: Text("Change Price")),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
