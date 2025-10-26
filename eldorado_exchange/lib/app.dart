import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/dependencies.dart';

import 'features/exchange/presentation/cubit/currencies_cubit.dart';
import 'features/exchange/presentation/cubit/exchange_cubit.dart';
import 'features/exchange/presentation/pages/exchange_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CurrenciesCubit(deps.loadCurrencies)),
        BlocProvider(create: (_) => ExchangeCubit(deps.getQuote)),
      ],
      child: MaterialApp(
        title: 'ElDorado Exchange',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF7A800)),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const ExchangePage(),
      ),
    );
  }
}
