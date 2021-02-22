import 'package:equatable/equatable.dart';
import 'package:quotes_generator/models/quote.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();
}

class QuoteInitial extends QuoteState {
  const QuoteInitial();

  @override
  List<Object> get props => <Object>[];
}

class QuoteLoaded extends QuoteState {
  final Quote quote;
  const QuoteLoaded(this.quote);

  @override
  List<Object> get props => <Object>[quote];
}

class QuoteError extends QuoteState {
  final String message;
  const QuoteError(this.message);

  @override
  List<Object> get props => <Object>[message];
}