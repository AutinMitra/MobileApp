import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
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