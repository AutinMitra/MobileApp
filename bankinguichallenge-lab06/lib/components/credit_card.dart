import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class BankingCard extends StatefulWidget {
  BankingCard({
    @required this.model
  }) : assert(model != null);
  final BankingCardModel model;

  @override
  _BankingCardState createState() => _BankingCardState();
}

class _BankingCardState extends State<BankingCard> {
  bool pressed = false;

  @override
  Widget build(context) {
    var cardIsDark = widget.model.cardBrightness == Brightness.dark;
    var bgColor = cardIsDark ? Colors.black : Palette.bg;
    
    final cardItem = ({Widget child}) => Styled.widget(child: child)
        .height(212)
        .borderRadius(all: 24.0)
        .ripple(
          highlightColor: Colors.transparent,
          splashColor: cardIsDark ? Color(0x30000000) : Color(0x30FFFFFF)

        )
        .backgroundColor(bgColor, animate: true)
        .clipRRect(all: 24)
        .elevation(
          pressed ? 0 : 12,
          shadowColor: Color(0x30000000),
          borderRadius: BorderRadius.circular(24),
        )
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTap: () {
            Navigator.pushNamed(context, '/card', arguments: widget.model);
          },
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 150), Curves.easeOut);

    return cardItem(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logo(),
            bottomText(),
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: new DecorationImage(
          image: new AssetImage(widget.model.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget bottomText() {
    var cardIsDark = widget.model.cardBrightness == Brightness.dark;
    var textColor = cardIsDark ? Palette.bg : Palette.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.model.balanceFormatted, style: cardBottomTextPrimary.copyWith(color: textColor)),
        SizedBox(height: 8),
        Text(widget.model.cardType, style: cardBottomTextSecondary),
      ],
    );
  }
}

class AddBankingCard extends StatefulWidget {
  @override
  _AddBankingCard createState() => _AddBankingCard();


}

class _AddBankingCard extends State<AddBankingCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final cardItem = ({Widget child}) => Styled.widget(child: child)
        .borderRadius(all: 24.0)
        .backgroundColor(Colors.transparent, animate: true)
        .clipRRect(all: 24)
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTap: () {
            Navigator.pushNamed(context, "/card/add");
          },
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 150), Curves.easeOut);

    return cardItem(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(24),
        strokeWidth: 4,
        dashPattern: [8, 4],
        color: Palette.textSecondary,
        child: Container(
          width: 132,
          height: 206,
          child: Center(
            child: Icon(
              Icons.add,
              color: Palette.textSecondary,
            ),
          ),
        ),
      ),
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