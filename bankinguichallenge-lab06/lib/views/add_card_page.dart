import 'package:bankinguichallenge/blocs/bank_info_bloc.dart';
import 'package:bankinguichallenge/components/buttons.dart';
import 'package:bankinguichallenge/components/text_fields.dart';
import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _cardTypeController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();

  var _currentItem = 0;

  void addCard() {
    if (_formKey.currentState.validate()) {
      var cardType = _cardTypeController.text;

      var cardNumber = _cardNumberController.text;
      RegExp exp = new RegExp(r"\d{4}");
      Iterable<Match> matches = exp.allMatches(cardNumber);
      var cardSplit = matches.map((matches) => int.tryParse(matches.group(0)));

      var finalCardNumber = cardSplit.join("-");
      var assetPath, issuerName;

      if (_currentItem == 0) {
        assetPath = "assets/graphics/mastercard.png";
        issuerName = "Mastercard";
      } else if (_currentItem == 1) {
        assetPath = "assets/graphics/apple.png";
        issuerName = "Apple";
      } else {
        assetPath = "assets/graphics/visa.png";
        issuerName = "Visa";
      }

      var brightness = _currentItem == 2 ? Brightness.dark : Brightness.light;

      var model = BankingCardModel(
        cardNumber: finalCardNumber,
        imagePath: assetPath,
        issuerName: issuerName,
        cardBrightness: brightness,
        balance: 0.0,
        cardType: cardType
      );

      // ignore: close_sinks
      final BankInfoBloc bankBloc = BlocProvider.of<BankInfoBloc>(context);
      bankBloc.add(AddCardEvent(model));
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: BackButton(
            color: Palette.text,
          ),
        ),
      ),
      body: _form(),
    );
  }

  Widget _form() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
          children: [
            Text("Add Card", style: pageTitle,),
            SizedBox(height: 24),
            SizedBox(height: 12),
            AdvancedFormTextField(
              validator: (str) {
                if (str.isEmpty)
                  return "Please input a value";
                return null;
              },
              controller: _cardTypeController,
              labelText: "Card Type",
            ),
            SizedBox(height: 12),
            AdvancedFormTextField(
              validator: (str) {
                if (str.length != 12)
                  return "Credit card number must be 12 digits.";
                if (str.isEmpty)
                  return "Please input a value";
                if (double.tryParse(str) == null)
                  return "Please input a valid number";
                return null;
              },
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              labelText: "Card Number",
            ),
            SizedBox(height: 24),
            creditCardProviderSelector(),
            SizedBox(height: 24),
            CustomRaisedButton(
              onTap: addCard,
              child: Text("Add Card", style: buttonText,),
            )
          ],
        ),
      ),
    );
  }

  Widget creditCardProviderSelector() {
    return Row(
      children: [
        _buttonItem(
            imagePath: "assets/graphics/mastercard.png",
            pressed: _currentItem == 0,
            onTap: () { setState(() {  _currentItem = 0; }); }
        ),
        SizedBox(width: 8,),
        _buttonItem(
            imagePath: "assets/graphics/apple.png",
            pressed: _currentItem == 1,
            onTap: () { setState(() {  _currentItem = 1; }); }
        ),
        SizedBox(width: 8,),
        _buttonItem(
            imagePath: "assets/graphics/visa.png",
            pressed: _currentItem == 2,
            onTap: () { setState(() {  _currentItem = 2; }); }
        ),
      ],
    );
  }

  Widget _buttonItem({imagePath, pressed, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Palette.bg,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
              color: pressed ? Palette.red : Palette.text,
              width: 3.0
          ),
        ),
        child: Center(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}