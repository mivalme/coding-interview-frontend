import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/currencies_cubit.dart';
import '../cubit/exchange_cubit.dart';
import '../../data/models/currency_item.dart';

import 'widgets/exchange_background.dart';
import 'widgets/exchange_card.dart';
import 'widgets/fullscreen_loader.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final _amountCtrl = TextEditingController();
  int _type = 1;

  CurrencyItem? _from;
  CurrencyItem? _to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CurrenciesCubit>().load();
    });
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: ExchangeBackground()),
          SafeArea(
            child: BlocBuilder<CurrenciesCubit, CurrenciesState>(
              builder: (context, curState) {
                if (curState is CurrenciesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (curState is CurrenciesError) {
                  return Center(child: Text('Error: ${curState.message}'));
                }

                final ready = curState as CurrenciesReady;
                final crypto = ready.crypto;
                final fiat = ready.fiat;

                if (crypto.isEmpty || fiat.isEmpty) {
                  return const Center(child: Text('No currencies available.'));
                }

                final isFiatToCrypto = _type == 1;
                final leftItems = isFiatToCrypto ? fiat : crypto;
                final rightItems = isFiatToCrypto ? crypto : fiat;

                final from = _from ?? leftItems.first;
                final to = _to ?? rightItems.first;

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ExchangeCard(
                      type: _type,
                      from: from,
                      to: to,
                      leftItems: leftItems,
                      rightItems: rightItems,
                      amountCtrl: _amountCtrl,
                      onPickFrom: (picked) => setState(() => _from = picked),
                      onPickTo: (picked) => setState(() => _to = picked),
                      onSwapDirection: _handleSwap,
                      onSubmit: () =>
                          _requestQuoteWith(from, to, isFiatToCrypto),
                    ),
                  ),
                );
              },
            ),
          ),

          BlocBuilder<ExchangeCubit, ExchangeState>(
            builder: (context, state) {
              return state is ExchangeLoading
                  ? const FullScreenLoader()
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _handleSwap() {
    setState(() {
      final wasFiatToCrypto = _type == 1;
      _type = wasFiatToCrypto ? 0 : 1;

      final tmp = _from;
      _from = _to;
      _to = tmp;

      _amountCtrl.text = '';
      FocusScope.of(context).unfocus();
    });

    context.read<ExchangeCubit>().clear();
  }

  void _requestQuoteWith(
    CurrencyItem from,
    CurrencyItem to,
    bool isFiatToCrypto,
  ) {
    final amount = double.tryParse(_amountCtrl.text.trim()) ?? 0;
    if (amount <= 0) return;

    late final String cryptoId;
    late final String fiatId;

    if (isFiatToCrypto) {
      fiatId = from.id;
      cryptoId = to.id;
    } else {
      cryptoId = from.id;
      fiatId = to.id;
    }

    final amountCurrencyId = isFiatToCrypto ? fiatId : cryptoId;

    context.read<ExchangeCubit>().request(
      type: _type,
      cryptoId: cryptoId,
      fiatId: fiatId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
      targetCode: to.code,
    );
  }
}
