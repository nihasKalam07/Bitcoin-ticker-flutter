import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency, String cryptoName) async {
    String apiKey = "Coin API KEY";
    var url = Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/$cryptoName/$currency?apiKey=$apiKey");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      double rate = jsonData["rate"];
      return rate.toInt().toString();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
