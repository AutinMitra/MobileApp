import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({
    this.model
  }) : assert(model != null);

  final TransactionModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftSide(),
          rightSide(),
        ],
      ),
    );
  }

  Widget leftSide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logo(),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.vendorName, style: transactionBold,),
            Text(model.cardType, style: transactionSecondary,)
          ],
        )
      ],
    );
  }

  Widget logo() {
    var balanceIncreased = model.amountMoved > 0;
    var bg = balanceIncreased ? Palette.green150 : Palette.red150;
    var text = balanceIncreased ? Palette.green600 : Palette.red;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bg,
      ),
      child: Center(
        child: Icon(
          balanceIncreased ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
          color: text,
          size: 36,
        ),
      ),
    );
  }

  Widget rightSide() {
    var balanceIncreased = model.amountMoved > 0;
    var text = balanceIncreased ? Palette.green600 : Palette.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(model.amountMovedFormatted, style: transactionBold.copyWith(color: text),),
        Text(model.dateFormatted, style: transactionSecondary,)
      ],
    );
  }
}
