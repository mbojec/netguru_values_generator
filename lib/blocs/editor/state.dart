import 'package:equatable/equatable.dart';

abstract class EditorState extends Equatable{
  const EditorState();
}

class EditorInitial extends EditorState {
  const EditorInitial();

  @override
  List<Object> get props => <Object>[];
}

class EditorClean extends EditorState {
  const EditorClean();

  @override
  List<Object> get props => <Object>[];
}

class EditorSuccess extends EditorState {
  const EditorSuccess();

  @override
  List<Object> get props => <Object>[];
}

class EditorSaving extends EditorState {
  const EditorSaving();

  @override
  List<Object> get props => <Object>[];
}

class EditorError extends EditorState {
  final String message;
  const EditorError(this.message);

  @override
  List<Object> get props => <Object>[message];
}