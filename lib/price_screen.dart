import 'dart:io' show Platform;

import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:bitcoin_ticker_flutter/reusable_crypto_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  CoinData coinData = CoinData();
  String btcExchangeRate = "?";
  String ethExchangeRate = "?";
  String ltcExchangeRate = "?";

  DropdownButton<String> AndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          setExchangeRate();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> children = [];
    for (String currency in currenciesList) {
      children.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          setExchangeRate();
        });
      },
      children: children,
    );
  }

  void setExchangeRate() async {
    String btcRate = await coinData.getCoinData(selectedCurrency, "BTC");
    String ethRate = await coinData.getCoinData(selectedCurrency, "ETH");
    String ltcRate = await coinData.getCoinData(selectedCurrency, "LTC");
    print(btcRate);
    print(ethRate);
    print(ltcRate);
    setState(() {
      btcExchangeRate = btcRate;
      ethExchangeRate = ethRate;
      ltcExchangeRate = ltcRate;
    });
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
              CryptoCard(
                cryptoName: "BTC",
                exchangeRate: btcExchangeRate,
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoName: "ETH",
                exchangeRate: ethExchangeRate,
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoName: "LTC",
                exchangeRate: ltcExchangeRate,
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? AndroidDropdown() : iOSPicker(),
          ),
        ],
      ),
    );
  }
}
