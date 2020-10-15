import 'package:bankinguichallenge/blocs/bank_info_bloc.dart';
import 'package:bankinguichallenge/components/transaction_card.dart';
import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/models/transaction_model.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/credit_card.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.sc,
      body: BlocBuilder<BankInfoBloc, BankInfoState>(builder: (context, state) {
        if (state is BankInfoLoadedState) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                bankingAppBar(),
                cardList(state.cards),
                _HomePageBackDrop(
                  transactions: state.transactions,
                  amountSpent: state.transactionSumFormatted,
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text("Loading...", style: pageTitle)
        );
      }),
    );
  }

  Widget bankingAppBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My cards",
            style: pageTitleHome,
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Palette.red,
              borderRadius: BorderRadius.circular(42),
              image: DecorationImage(
                image: new AssetImage("assets/graphics/profile.jpeg"),
                fit: BoxFit.cover,
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget cardList(List<BankingCardModel> cards) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          for(var i = 0; i < cards.length; i++)
            Padding(
              padding: EdgeInsets.only(right: i < cards.length-1 ? 16.0 : 0),
              child: BankingCard(model: cards[i]),
            ),
        ],
      ),
    );
  }
}

class _HomePageBackDrop extends StatelessWidget {
  _HomePageBackDrop({@required this.transactions, @required this.amountSpent});

  final List<TransactionModel> transactions;
  final String amountSpent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Material(
          elevation: 12,
          shadowColor: Color(0x30000000),
          color: Palette.bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                backdropHeader(),
                transactionView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget backdropHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Transactions",
          style: transactionHeader
        ),
        Text(
          amountSpent,
          style: transactionHeader
        ),
      ],
    );
  }

  Widget transactionView() {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0x00FFFFFF), Colors.white],
          ).createShader(Rect.fromLTRB(0, 0, bounds.width, 36));
        },
        child: ListView(
          children: [
            SizedBox(height: 12),
            for(var i = 0; i < transactions.length; i++)
              TransactionCard(model: transactions[i]),
            SizedBox(height: 24)
          ],
        ),
        blendMode: BlendMode.dstATop,
      ),
    );
  }
}
