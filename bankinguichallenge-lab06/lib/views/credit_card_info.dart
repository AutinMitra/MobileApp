import 'package:bankinguichallenge/components/buttons.dart';
import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';


class CreditCardInfoPage extends StatefulWidget {
  @override
  _CreditCardInfoPageState createState() => _CreditCardInfoPageState();
}

class _CreditCardInfoPageState extends State<CreditCardInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: BackButton(
              color: Palette.text,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: form(),
    );
  }

  Widget form() {
    final BankingCardModel model = ModalRoute.of(context).settings.arguments;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Card Info", style: pageTitle),
            SizedBox(height: 16,),
            CreditInfoCard(model),
            SizedBox(height: 24),
            Container(
              child: Row(
                children: [
                  Expanded(child: additionalCardInfo(title: "Current Limit", value: "${model.balanceFormatted}", background: Palette.orange)),
                  SizedBox(width: 12),
                  Expanded(child: additionalCardInfo(title: "Payment Due", value: "\$1200.00", background: Palette.blue))
                ],
              ),
            ),
            SizedBox(height: 24),
            CustomRaisedButton(
              elevation: 12.0,
              onTap: () {
                Navigator.pushNamed(context, "/transaction/create", arguments: model);
              },
              child: Text(
                "Create Transaction",
                style: buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget additionalCardInfo({String title, String value, Color background}) {
    final cardItem = ({Widget child}) => Styled.widget(child: child)
        .backgroundColor(background)
        .height(86)
        .borderRadius(all: 24)
        .clipRRect(all: 24)
        .elevation(
          12.0,
          shadowColor: background.withOpacity(0.4),
          borderRadius: BorderRadius.circular(24)
        );

    return cardItem(
      child: DefaultTextStyle(
        style: TextStyle(color: Palette.bg),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(title, style: textMd,),
                  Text(value, style: paraHeader,)
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class CreditInfoCard extends StatelessWidget {
  CreditInfoCard(this.model);
  final BankingCardModel model;

  @override
  Widget build(BuildContext context) {
    var bg = Colors.white;
    var text = Colors.black;
    var cardText = text.withOpacity(0.8);

    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(24),
      elevation: 12,
      shadowColor: Color(0x30000000),
      child: Container(
        padding: EdgeInsets.all(24),
        height: 212,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bg,
          image: new DecorationImage(
            image: new AssetImage("assets/graphics/cardbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: text),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.issuerName, style: transactionBold.copyWith(color: cardText.withOpacity(0.4)),),
                  logo(),
                ],
              ),
              Text(model.cardNumber, style: monoCreditCardBalanceNumber,),
              Text(model.balanceFormatted, style: monoCreditCardBalanceText),
            ],
          )
        ),
      ),
    );
  }

  Widget logo() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(model.imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12)
      ),
    );
  }

}