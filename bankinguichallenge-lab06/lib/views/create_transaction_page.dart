import 'package:bankinguichallenge/blocs/bank_info_bloc.dart';
import 'package:bankinguichallenge/components/buttons.dart';
import 'package:bankinguichallenge/components/text_fields.dart';
import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/models/transaction_model.dart';
import 'package:bankinguichallenge/theme/fontstyles.dart';
import 'package:bankinguichallenge/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateTransactionPage extends StatefulWidget {
  @override
  _CreateTransactionPageState createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _vendorController = TextEditingController();
  TextEditingController _costController = TextEditingController();

  DateTime _selectedDateTime = DateTime.now();
  bool _selectingDate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
        body: Center(child: form()),
      ),
    );
  }

  void addTransaction() {
    final BankingCardModel model = ModalRoute
        .of(context)
        .settings
        .arguments;

    if (_formKey.currentState.validate()) {
      var vendorName = _vendorController.text;
      var cost = double.parse(_costController.text);
      var transaction = TransactionModel(
        vendorName: vendorName,
        amountMoved: cost * -1,
        cardType: model.cardType,
        date: _selectedDateTime,
      );
      // ignore: close_sinks
      final BankInfoBloc bankBloc = BlocProvider.of<BankInfoBloc>(context);
      bankBloc.add(
          AddTransactionEvent(cardId: model.id, transaction: transaction));
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }
  }

  void _selectDate() async {
    _selectingDate = true;
    FocusScope.of(context).requestFocus(new FocusNode());

    var picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    setState(() {
      _selectedDateTime = picked ?? DateTime.now();
      _selectingDate = false;
    });
  }

  Widget form() {
    var dateFormatted = DateFormat.yMd().format(_selectedDateTime);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          clipBehavior: Clip.none,
          children: [
            Text("Add Transaction",
              style: pageTitle,),
            SizedBox(height: 24),
            AdvancedFormTextField(
              labelText: "Vendor Name",
              enabled: !_selectingDate,
              controller: _vendorController,
              validator: (text) {
                if (text.isEmpty)
                  return "Please insert a vendor name.";
                return null;
              },
            ),
            SizedBox(height: 12),
            AdvancedFormTextField(
              labelText: "Cost",
              enabled: !_selectingDate,
              controller: _costController,
              keyboardType: TextInputType.number,
              validator: (text) {
                if (double.tryParse(text) == null || text.isEmpty)
                  return "Please insert a valid number.";
                return null;
              },
            ),
            SizedBox(height: 24),
            CustomRaisedButton(
              onTap: _selectDate,
              elevation: 12.0,
              child: Text(
                "Date: $dateFormatted",
                style: buttonText,
              ),
            ),
            SizedBox(height: 12),
            CustomRaisedButton(
              elevation: 12.0,
              onTap: addTransaction,
              color: Palette.green600,
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
}