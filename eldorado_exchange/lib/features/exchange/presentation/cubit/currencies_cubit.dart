import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/currency_item.dart';
import '../../domain/usecases/load_currencies.dart';

sealed class CurrenciesState {
  const CurrenciesState();
}

class CurrenciesLoading extends CurrenciesState {}

class CurrenciesReady extends CurrenciesState {
  final List<CurrencyItem> crypto;
  final List<CurrencyItem> fiat;
  const CurrenciesReady({required this.crypto, required this.fiat});
}

class CurrenciesError extends CurrenciesState {
  final String message;
  const CurrenciesError(this.message);
}

class CurrenciesCubit extends Cubit<CurrenciesState> {
  final LoadCurrencies _loadCurrencies;
  CurrenciesCubit(this._loadCurrencies) : super(CurrenciesLoading());

  Future<void> load() async {
    emit(CurrenciesLoading());
    try {
      final res = await _loadCurrencies();
      emit(CurrenciesReady(crypto: res.crypto, fiat: res.fiat));
    } catch (e) {
      emit(CurrenciesError(e.toString()));
    }
  }
}
