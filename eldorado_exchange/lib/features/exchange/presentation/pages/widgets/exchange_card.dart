import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/currency_item.dart';
import '../../cubit/exchange_cubit.dart';
import 'selector_button.dart';
import 'currency_picker_sheet.dart';
import 'amount_field.dart';
import 'quote_area.dart';
import 'swap_button.dart';

class ExchangeCard extends StatelessWidget {
  const ExchangeCard({
    super.key,
    required this.type,
    required this.from,
    required this.to,
    required this.leftItems,
    required this.rightItems,
    required this.amountCtrl,
    required this.onPickFrom,
    required this.onPickTo,
    required this.onSwapDirection,
    required this.onSubmit,
  });

  final int type;
  final CurrencyItem from;
  final CurrencyItem to;
  final List<CurrencyItem> leftItems;
  final List<CurrencyItem> rightItems;
  final TextEditingController amountCtrl;
  final ValueChanged<CurrencyItem> onPickFrom;
  final ValueChanged<CurrencyItem> onPickTo;
  final VoidCallback onSwapDirection;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final isFiatToCrypto = type == 1;

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(28),
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SelectorButton(
                  label: 'TENGO',
                  value: from,
                  onTap: () async {
                    final picked = await showCurrencyPicker(
                      context: context,
                      title: isFiatToCrypto ? 'Fiat' : 'Cripto',
                      items: leftItems,
                      selected: from,
                    );
                    if (picked != null) onPickFrom(picked);
                  },
                ),
                Expanded(child: SwapButton(onTap: onSwapDirection)),

                SelectorButton(
                  label: 'QUIERO',
                  value: to,
                  alignRight: true,
                  onTap: () async {
                    final picked = await showCurrencyPicker(
                      context: context,
                      title: isFiatToCrypto ? 'Cripto' : 'Fiat',
                      items: rightItems,
                      selected: to,
                    );
                    if (picked != null) onPickTo(picked);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            AmountField(controller: amountCtrl, prefix: from.code),

            const SizedBox(height: 16),

            const QuoteArea(),

            const SizedBox(height: 16),

            BlocBuilder<ExchangeCubit, ExchangeState>(
              builder: (context, state) {
                final loading = state is ExchangeLoading;
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: loading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Cambiar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
