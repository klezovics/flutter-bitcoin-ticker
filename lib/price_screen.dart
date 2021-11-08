import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'USD';
  var _coinData = CoinData();
  var isWaiting = true;

  var rateBtc = "?";
  var rateEth = "?";
  var ratePush = "?";

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: _selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void getData() async {
    isWaiting = true;
    try {
      print("Getting data");
      var d1 = (await _coinData.getExchangeRate("BTC", _selectedCurrency))
          .toStringAsFixed(2);
      var d2 = (await _coinData.getExchangeRate("ETH", _selectedCurrency))
          .toStringAsFixed(2);
      var d3 = (await _coinData.getExchangeRate("PUSH", _selectedCurrency))
          .toStringAsFixed(2);
      setState(() {
        rateBtc = d1;
        rateEth = d2;
        ratePush = d3;
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print('Done state init');
    try {
      getData();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: buildCryptoCard(
                    'BTC', isWaiting ? '?' : rateBtc, _selectedCurrency),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: buildCryptoCard(
                    'ETH', isWaiting ? '?' : rateEth, _selectedCurrency),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: buildCryptoCard(
                    'PUSH', isWaiting ? '?' : ratePush, _selectedCurrency),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropdown(),
          ),
        ],
      ),
    );
  }

  Card buildCryptoCard(String cryptoName, String rate, String currency) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoName = $rate $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
