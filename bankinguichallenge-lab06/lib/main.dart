import 'package:bankinguichallenge/blocs/bank_info_bloc.dart';
import 'package:bankinguichallenge/services/banking_file_utils.dart';
import 'package:bankinguichallenge/theme/theme.dart';
import 'package:bankinguichallenge/views/create_transaction_page.dart';
import 'package:bankinguichallenge/views/credit_card_info.dart';
import 'package:bankinguichallenge/views/home_page.dart';
import 'package:bankinguichallenge/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BankingStorageUtils.prefs = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<BankInfoBloc>(create: (context) => BankInfoBloc(BankInfoUninitializedState())),
    ],
    child: BankingApp()
  ));
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final BankInfoBloc bankBloc = BlocProvider.of<BankInfoBloc>(context);
    bankBloc.add(LoadBankInfoEvent());

    var firstRunKey = BankingStorageUtils.firstRunPrefs;
    var isFirstRun = BankingStorageUtils.prefs.getBool(firstRunKey) ?? true;

    return MaterialApp(
      theme: Themes.lightMode,
      home: HomePage(),
      initialRoute: isFirstRun ? '/welcome' : '/',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/card': (context) => CreditCardInfoPage(),
        '/transaction/create': (context) => CreateTransactionPage()
      },
    );
  }
}


