import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CurrencyData.dart';
import 'dart:convert';

class CurrencyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CurrencyListState();
  }
}

class CurrencyListState extends State<CurrencyList> {
  List<CurrencyData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currencies'),
      ),
      body: Container(child: ListView(children: _buildCurrencyList())),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCurrencies(),
      ),
    );
  }

  _loadCurrencies() async {
    String serviceUrl = 'https://cms.bet25.dk/rest/seo/get-seo-data';

    // try{

    // } catch() {

    // }

    Map<String, String> headers = {
      "x-rapidapi-host": "zloadr-cryptocurrency-v1.p.rapidapi.com",
      "x-rapidapi-key": "71f2022b5bmshd8795eeea50b720p1f314cjsnf06f532ae75f",
      "useQueryString": "true",
    };

    final response = await http.get(serviceUrl, headers: headers);
    List<CurrencyData> currencyList = [];

    if (response.statusCode == 200) {
      var jsonData = (json.decode(response.body) as Map)['data'];
      print(jsonData.runtimeType);
      //   (json.encode(response.body) as Map)['data'] as Map<String, dynamic>;

      for (var i = 0; i < jsonData.length; i++) {
        var value = jsonData[i];
        currencyList.add(CurrencyData(
            name: value['url'],
            symbol: value['module'],
            rank: i,
            price: 5 + i.toDouble()));
      }
      // jsonData.forEach((key, value) {
      //   currencyList.add(CurrencyData(
      //       name: value['url'],
      //       symbol: value['module_name'],
      //       rank: 1,
      //       price: 0));
      // });
    }

    setState(() {
      data = currencyList;
    });
  }

  List<Widget> _buildCurrencyList() {
    return data
        .map((CurrencyData item) => ListTile(
              subtitle: Text(item.symbol),
              title: Text(item.name),
              leading: CircleAvatar(
                child: Text(item.rank.toString()),
              ),
              trailing: Text('\$${item.price}'),
              hoverColor: Colors.red,
            ))
        .toList();
  }
}
