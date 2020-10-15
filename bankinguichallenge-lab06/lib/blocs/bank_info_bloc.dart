import 'package:bankinguichallenge/models/bankingcard_model.dart';
import 'package:bankinguichallenge/models/transaction_model.dart';
import 'package:bankinguichallenge/services/banking_file_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BankInfoState extends Equatable {
  BankInfoState([this._props]) : super();

  final List _props;

  @override
  List<Object> get props => _props;
}

class BankInfoUninitializedState extends BankInfoState {}

class BankInfoLoadedState extends BankInfoState {
  BankInfoLoadedState({@required this.cards, @required this.transactions})
      : assert(cards != null),
        assert(transactions != null),
        super([cards, transactions]);

  final List<BankingCardModel> cards;
  final List<TransactionModel> transactions;

  double get transactionSum {
    double sum = 0;
    transactions.forEach((element) { sum += element.amountMoved; });
    return sum;
  }

  String get transactionSumFormatted {
    final oCcy = new NumberFormat("\$#,##0.00", "en_US");
    var movedFormatted = oCcy.format(transactionSum);
    return movedFormatted;
  }
}

class BankInfoEvent {}

class LoadBankInfoEvent extends BankInfoEvent {}

class AddTransactionEvent extends BankInfoEvent {
  AddTransactionEvent({
    @required this.cardId,
    @required this.transaction
  }) : assert(cardId != null),
  assert(transaction != null);

  final String cardId;
  final TransactionModel transaction;
}

class BankInfoBloc extends Bloc<BankInfoEvent, BankInfoState> {
  BankInfoBloc(BankInfoState initialState) : super(initialState);

  @override
  Stream<BankInfoState> mapEventToState(BankInfoEvent event) async* {
    if (event is LoadBankInfoEvent)
      yield* mapLoadEventToState(event);
    else if (event is AddTransactionEvent)
      yield* mapAddTransactionEventToState(event);
  }

  Stream<BankInfoState> mapLoadEventToState(LoadBankInfoEvent event) async* {
    yield BankInfoUninitializedState();

    var cards = await BankingStorageUtils.loadBankingCards();
    var transactions = await BankingStorageUtils.loadTransactions();
    yield BankInfoLoadedState(cards: cards, transactions: transactions);
  }

  Stream<BankInfoState> mapAddTransactionEventToState(AddTransactionEvent event) async* {
    yield BankInfoUninitializedState();

    if (state is BankInfoLoadedState) {
      var loadedState = state as BankInfoLoadedState;
      var newTransactions = [event.transaction] + loadedState.transactions;
      Comparator<TransactionModel> sortByDate = (a, b) => a.date.compareTo(b.date);

      List<BankingCardModel> newCards = List.from(loadedState.cards);
      for (var i = 0; i < newCards.length; i++) {
        BankingCardModel card = newCards[i];
        if (card.id == event.cardId) {
          var newCard = BankingCardModel(
            balance: card.balance + event.transaction.amountMoved,
            cardType: card.cardType,
            issuerName: card.issuerName,
            imagePath: card.imagePath,
            cardBrightness: card.cardBrightness,
            id: card.id,
            cardNumber: card.cardNumber,
          );
          newCards[i] = newCard;
          newTransactions.sort(sortByDate);
          newTransactions = newTransactions.reversed.toList();
        }
      }
      BankingStorageUtils.saveTransactions(newTransactions);
      BankingStorageUtils.saveBankingCards(newCards);
      yield BankInfoLoadedState(cards: newCards, transactions: newTransactions);
    }
  }
}
