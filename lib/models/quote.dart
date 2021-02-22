import 'package:flutter/foundation.dart';

class Quote {
  int id;
  String content;
  bool isFavorite;

  Quote({this.id, @required this.content, this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'is_favorite': isFavorite ? 1 : 0
    };
  }

  Quote.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    if (json['is_favorite'] == 0) {
      isFavorite = false;
    } else {
      isFavorite = true;
    }
  }
}
