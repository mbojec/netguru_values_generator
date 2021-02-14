abstract class EditorState {
  const EditorState();
}

class EditorInitial extends EditorState {
  const EditorInitial();
}

class EditorSuccess extends EditorState {
  const EditorSuccess();
}

class EditorSaving extends EditorState {
  const EditorSaving();
}

class EditorError extends EditorState {
  final String message;
  const EditorError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EditorError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}