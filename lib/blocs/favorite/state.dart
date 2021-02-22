import 'package:equatable/equatable.dart';
import 'package:quotes_generator/models/quote.dart';

abstract class FavoriteQuotesState extends Equatable {
  const FavoriteQuotesState();
}

class FavoriteQuotesInitial extends FavoriteQuotesState {
  const FavoriteQuotesInitial();

  @override
  List<Object> get props => <Object>[];
}

class FavoriteQuotesLoading extends FavoriteQuotesState {
  const FavoriteQuotesLoading();

  @override
  List<Object> get props => <Object>[];
}

class FavoriteQuotesLoaded extends FavoriteQuotesState {
  final List<Quote> quotes;
  const FavoriteQuotesLoaded(this.quotes);

  @override
  List<Object> get props => <Object>[quotes];
}

class FavoriteQuotesError extends FavoriteQuotesState {
  final String message;
  const FavoriteQuotesError(this.message);

  @override
  List<Object> get props => <Object>[message];
}