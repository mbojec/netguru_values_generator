import 'package:netguru_values_generator/models/quote.dart';

abstract class FavoriteQuotesState {
  const FavoriteQuotesState();
}

class FavoriteQuotesInitial extends FavoriteQuotesState {
  const FavoriteQuotesInitial();
}

class FavoriteQuotesLoading extends FavoriteQuotesState {
  const FavoriteQuotesLoading();
}

class FavoriteQuotesLoaded extends FavoriteQuotesState {
  final List<Quote> quotes;
  const FavoriteQuotesLoaded(this.quotes);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FavoriteQuotesLoaded && o.quotes == quotes;
  }

  @override
  int get hashCode => quotes.hashCode;
}

class FavoriteQuotesError extends FavoriteQuotesState {
  final String message;
  const FavoriteQuotesError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FavoriteQuotesError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}