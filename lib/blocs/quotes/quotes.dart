import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_generator/blocs/quotes/state.dart';
import 'package:quotes_generator/models/quote.dart';
import 'package:quotes_generator/storage/database_helper.dart';

class QuotesCubit extends Cubit<QuotesState>{
  QuotesCubit():super(const QuotesInitial());
  List<Quote> list;

  Future<void> getQuotes() async {
    emit(const QuotesLoading());
    try{
      final List<Quote> list = await DatabaseHelper().values();
      this.list = list;
      emit(QuotesLoaded(list));
    } catch(e){
      emit(const QuotesError("There's been an error during fetching values list"));
    }
  }

  Future<void> updateQuotes() async {
    try{
      final List<Quote> list = await DatabaseHelper().values();
      emit(QuotesLoaded(list));
    } catch(e){
      emit(const QuotesError("There's been an error during fetching values list"));
    }
  }

  Future<void> changeFavoriteState(Quote quote) async {
    quote.isFavorite = !quote.isFavorite;
    try{
      await DatabaseHelper().update(quote);
      updateQuotes();
    } catch(e){
      emit(const QuotesError("There's been an error during fetching values list"));
    }
  }

  Future<void> getFavoriteQuotes() async {
    emit(const QuotesLoading());
    try{
      final List<Quote> list = await DatabaseHelper().favoriteValues();
      this.list = list;
      emit(QuotesLoaded(list));
    } catch(e){
      emit(const QuotesError("There's been an error during fetching values list"));
    }
  }
}

