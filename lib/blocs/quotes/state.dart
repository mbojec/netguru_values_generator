import 'package:equatable/equatable.dart';
import 'package:quotes_generator/models/quote.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();
}

class QuotesInitial extends QuotesState {
  const QuotesInitial();

  @override
  List<Object> get props => <Object>[];
}

class QuotesLoading extends QuotesState {
  const QuotesLoading();

  @override
  List<Object> get props => <Object>[];
}

class QuotesLoaded extends QuotesState {
  final List<Quote> quotes;
  const QuotesLoaded(this.quotes);

  @override
  List<Object> get props => <Object>[quotes];
}

class QuotesError extends QuotesState {
  final String message;
  const QuotesError(this.message);

  @override
  List<Object> get props => <Object>[message];
}