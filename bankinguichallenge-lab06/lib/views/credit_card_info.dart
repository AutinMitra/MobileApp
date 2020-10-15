import 'package:bankinguichallenge/blocs/bank_info_bloc.dart';
import 'package:bankinguichallenge/components/buttons.dart';
import 'package:bankinguichallenge/components/credit_card.dart';
import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:bankinguichallenge/views/add_transaction_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';


class CreditCardInfoPage extends StatefulWidget {
  @override
  _CreditCardInfoPageState createState() => _CreditCardInfoPageState();
}

class _CreditCardInfoPageState extends State<CreditCardInfoPage> {
  void removeCard() {
    final BankingCardModel model = ModalRoute.of(context).settings.arguments;

    // ignore: close_sinks
    final BankInfoBloc bankBloc = BlocProvider.of<BankInfoBloc>(context);
    bankBloc.add(RemoveCardEvent(model));
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

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
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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
              Navigator.pushNamed(
                context, "/transaction/create",
                arguments: TransactionArguments(
                  sendingMoney: true,
                  model: model,
                ),
              );
            },
            child: Text(
              "Send Money",
              style: buttonText,
            ),
          ),
          SizedBox(height: 12),
          CustomRaisedButton(
            elevation: 12.0,
            onTap: () {
              Navigator.pushNamed(
                context, "/transaction/create",
                arguments: TransactionArguments(
                  sendingMoney: false,
                  model: model,
                ),
              );
            },
            color: Palette.green600,
            child: Text(
              "Receive Money",
              style: buttonText,
            ),
          ),
          SizedBox(height: 12),
          CustomRaisedButton(
            elevation: 12.0,
            onTap: removeCard,
            color: Palette.red,
            child: Text(
              "Remove Card",
              style: buttonText,
            ),
          ),
        ],
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