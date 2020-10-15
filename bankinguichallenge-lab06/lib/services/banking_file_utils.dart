import 'dart:convert';
import 'dart:ui';

import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import './file_utils.dart';

class BankingStorageUtils {

  // Some permanent storage variables
  static String cardsJSON = "cards.json";
  static String transactionsJSON = "transactions.json";
  static String firstRunPrefs = "firstRunPrefs";

  // SharedPreferences store configs, secureStorage stores secrets
  static SharedPreferences prefs;

  // A nice little hack to get some initial data
  static Future<void> _createSampleData() async {
    var uuid = Uuid();

    List<String> ids = [];
    for (var i = 0; i < 7; i++)
      ids.add(uuid.v4());

    var model1 = TransactionModel(
      vendorName: "UberEats",
      amountMoved: -32.02,
      cardType: "Credit Card",
      date: DateTime.now(),
      id: ids[0]
    );
    var model2 = TransactionModel(
        vendorName: "Lyft",
        amountMoved: -12.84,
        cardType: "Credit Card",
        date: DateTime.now(),
        id: ids[1]
    );
    var model3 = TransactionModel(
        vendorName: "Costco",
        amountMoved: -120.94,
        cardType: "Credit Card",
        date: DateTime.now(),
        id: ids[2]
    );
    var model4 = TransactionModel(
        vendorName: "Apple",
        amountMoved: -820.10,
        cardType: "Credit Card",
        date: DateTime.now(),
        id: ids[3],
    );
    var card1 = BankingCardModel(
      cardType: "Credit Card",
      issuerName: "MasterCard",
      balance: 4231.01,
      imagePath: "assets/graphics/mastercard.png",
      cardNumber: "5675-2344-2543",
      id: ids[4]
    );
    var card2 = BankingCardModel(
        cardType: "Credit Card",
        issuerName: "Apple",
        balance: 2303.32,
        imagePath: "assets/graphics/apple.png",
        cardNumber: "8945-3424-8903",
        id: ids[5]
    );
    var card3 = BankingCardModel(
        cardType: "Credit Card",
        issuerName: "Visa",
        balance: 6920.45,
        imagePath: "assets/graphics/visa.png",
        cardBrightness: Brightness.dark,
        cardNumber: "1434-9592-1234",
        id: ids[6]
    );

    await saveTransactions([model1, model2, model3, model4]);
    await saveBankingCards([card1, card2, card3]);
  }

  // Loads all the BankingCards from a JSON
  static Future<List<BankingCardModel>> loadBankingCards() async {
    // If there is no file, there is no items
    if (!await FileUtils.fileExists(cardsJSON))
      return [];

    // Read the file
    var data = await FileUtils.readFile(cardsJSON);
    List decoded = json.decode(data);
    List<BankingCardModel> res = decoded.map((jsonItem) => BankingCardModel.fromJson(jsonItem)).toList();
    return res;
  }

  static Future saveBankingCards(List<BankingCardModel> items) {
    // Turn JSON list to string
    var data = jsonEncode(items);
    return FileUtils.writeFile(cardsJSON, data).then((file) => {});
  }

  // Loads all the BankingCards from a JSON
  static Future<List<TransactionModel>> loadTransactions() async {
    // If there is no file, there is no items
    if (!await FileUtils.fileExists(transactionsJSON))
      return [];

    // Read the file
    var data = await FileUtils.readFile(transactionsJSON);
    List decoded = json.decode(data);
    List<TransactionModel> res = decoded.map((jsonItem) => TransactionModel.fromJson(jsonItem)).toList();
    return res;
  }

  static Future saveTransactions(List<TransactionModel> items) {
    // Turn JSON list to string
    var data = jsonEncode(items);
    return FileUtils.writeFile(transactionsJSON, data).then((file) => {});
  }
}