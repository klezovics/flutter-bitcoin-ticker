import 'dart:convert' as convert;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'YOUR-API-KEY-HERE';

class CoinData {
  var requestHeaders = {
    "X-CoinAPI-Key": "0316ADCD-64CD-4F33-A018-6E6AB8B435B6",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Accept"
  };

  Future<double> getExchangeRate(String cryptoId, String fiatId) async {
    var url = Uri.http('rest.coinapi.io', '/v1/exchangerate/$cryptoId/$fiatId');
    //Uri.http("www.google.com", "/");
    print("Sending request");
    var response = await http.get(url, headers: requestHeaders);
    print("Request sent");
    print("Response code ${response.statusCode}");
    print("Response body ${response.body}");

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return Future.value(jsonResponse["rate"] as double);
  }
}
