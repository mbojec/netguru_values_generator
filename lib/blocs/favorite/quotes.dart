import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_generator/blocs/favorite/state.dart';
import 'package:quotes_generator/models/quote.dart';
import 'package:quotes_generator/storage/database_helper.dart';

class FavoriteQuotesCubit extends Cubit<FavoriteQuotesState> {
  FavoriteQuotesCubit() : super(const FavoriteQuotesInitial());

  Future<void> getFavoriteQuotes() async {
    emit(const FavoriteQuotesLoading());
    try {
      final List<Quote> list = await DatabaseHelper().favoriteValues();
      emit(FavoriteQuotesLoaded(list));
    } catch (e) {
      emit(const FavoriteQuotesError(
          "There's been an error during fetching values list"));
    }
  }
}
