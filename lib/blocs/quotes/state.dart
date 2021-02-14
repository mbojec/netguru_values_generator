import 'package:netguru_values_generator/models/quote.dart';

abstract class QuotesState {
  const QuotesState();
}

class QuotesInitial extends QuotesState {
  const QuotesInitial();
}

class QuotesLoading extends QuotesState {
  const QuotesLoading();
}

class QuotesLoaded extends QuotesState {
  final List<Quote> quotes;
  const QuotesLoaded(this.quotes);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuotesLoaded && o.quotes == quotes;
  }

  @override
  int get hashCode => quotes.hashCode;
}

class QuotesError extends QuotesState {
  final String message;
  const QuotesError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuotesError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}