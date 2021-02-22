import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_generator/blocs/quote/state.dart';
import 'package:quotes_generator/models/quote.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit() : super(const QuoteInitial());

  Future<void> setQuote(Quote currentQuote) async {
    emit(QuoteLoaded(currentQuote));
  }
}
