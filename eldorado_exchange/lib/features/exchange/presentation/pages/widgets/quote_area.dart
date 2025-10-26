import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/exchange_cubit.dart';

class QuoteArea extends StatelessWidget {
  const QuoteArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeCubit, ExchangeState>(
      builder: (context, state) {
        double rate = 0;
        double receive = 0;
        String unit = '—';
        String etaLabel = '—';

        if (state is ExchangeLoaded) {
          rate = state.rateFiatToCrypto;
          receive = state.converted;
          unit = state.targetCode;
          if (state.etaMinutes != null) {
            etaLabel = state.etaMinutes.toString();
          }
        }

        return Column(
          children: [
            _LineItem(
              label: 'Tasa estimada',
              value: rate == 0 ? '—' : rate.toStringAsFixed(2),
              unit: unit,
            ),
            const SizedBox(height: 10),
            _LineItem(
              label: 'Recibirás',
              value: receive == 0 ? '—' : receive.toStringAsFixed(2),
              unit: unit,
            ),
            const SizedBox(height: 10),
            _LineItem(label: 'Tiempo estimado', value: etaLabel, unit: 'Min'),
          ],
        );
      },
    );
  }
}

class _LineItem extends StatelessWidget {
  const _LineItem({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final valueStyle = TextStyle(color: Colors.black87, fontSize: 16);

    return Row(
      children: [
        Expanded(child: Text(label, style: valueStyle)),
        Text('≈  ', style: valueStyle),
        Text(value, style: valueStyle),
        const SizedBox(width: 6),
        Text(unit, style: valueStyle),
      ],
    );
  }
}
