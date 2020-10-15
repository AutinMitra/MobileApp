import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class TransactionModel {
  final String vendorName;
  final double amountMoved;
  final String cardType;
  final DateTime date;
  final String id;

  factory TransactionModel(
      {@required vendorName,
        @required amountMoved,
        @required cardType,
        @required date,
        id}) {
    return TransactionModel._internal(
      vendorName: vendorName,
      amountMoved: amountMoved,
      cardType: cardType,
      date: date,
      id: id ?? Uuid().v4()
    );
  }

  TransactionModel._internal(
      {@required this.vendorName,
      @required this.amountMoved,
      @required this.cardType,
      @required this.date,
      @required this.id})
      : assert(vendorName != null),
        assert(amountMoved != null),
        assert(date != null),
        assert(id != null);

  String get amountMovedFormatted {
    final oCcy = new NumberFormat("\$#,##0.00", "en_US");
    var movedFormatted = oCcy.format(amountMoved);
    return movedFormatted;
  }

  String get dateFormatted {
    return DateFormat.yMd().format(date);
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    var vendorName = json["vendorName"];
    var amountMoved = json["amountMoved"];
    var cardType = json["cardType"];
    var date = DateFormat.yMd().parse(json["date"]);
    var id = json["id"];
    return TransactionModel._internal(
        vendorName: vendorName,
        amountMoved: amountMoved,
        cardType: cardType,
        date: date,
        id: id
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vendorName": vendorName,
      "amountMoved": amountMoved,
      "cardType": cardType,
      "date": dateFormatted,
      "id": id
    };
  }
}
