import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BankingCardModel {
  final double balance;
  final String cardType;
  final String issuerName;
  final String imagePath;
  final Brightness cardBrightness;
  final String cardNumber;
  final String id;

  factory BankingCardModel({
    balance = 0.0,
    cardType = "Credit Card",
    issuerName = "Vendor Unknown",
    imagePath,
    cardBrightness = Brightness.light,
    cardNumber,
    id
  }) {
    return BankingCardModel._internal(
      balance: balance,
      cardType: cardType,
      issuerName: issuerName,
      imagePath: imagePath,
      cardBrightness: cardBrightness,
      cardNumber: cardNumber,
      id: id ?? Uuid().v4()
    );
  }

  BankingCardModel._internal({
    this.balance = 0.0,
    this.cardType = "Credit Card",
    this.issuerName = "Vendor Unknown",
    this.imagePath,
    this.cardBrightness = Brightness.light,
    this.cardNumber = "1234-5678-9012",
    this.id
  });

  String get balanceFormatted {
    final oCcy = new NumberFormat("\$#,##0.00", "en_US");
    var balanceFormatted = oCcy.format(balance);
    return balanceFormatted;
  }

  factory BankingCardModel.fromJson(Map<String, dynamic> json) {
    var balance = json["balance"];
    var cardType = json["cardType"];
    var cardVendor = json["cardVendor"];
    var imagePath = json["imagePath"];
    var cardBrightness =
        json["cardDark"] == 1 ? Brightness.dark : Brightness.light;
    var cardNumber = json["cardNumber"];
    var id = json["id"];

    return BankingCardModel(
      balance: balance,
      cardType: cardType,
      issuerName: cardVendor,
      imagePath: imagePath,
      cardBrightness: cardBrightness,
      cardNumber: cardNumber,
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "balance": balance,
      "cardType": cardType,
      "cardVendor": issuerName,
      "imagePath": imagePath,
      "cardDark": cardBrightness == Brightness.dark ? 1 : 0,
      "cardNumber": cardNumber,
      "id": id
    };
  }
}
