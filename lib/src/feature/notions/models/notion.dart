// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Notion {
  final String id;
  String? notion;
  String? text;
  Notion({
    required this.id,
    this.notion,
    this.text,
  });

  

  Notion copyWith({
    String? id,
    String? notion,
    String? text,
  }) {
    return Notion(
      id: id ?? this.id,
      notion: notion ?? this.notion,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'notion': notion,
      'text': text,
    };
  }

  factory Notion.fromMap(Map<String, dynamic> map) {
    return Notion(
      id: map['id'] as String,
      notion: map['notion'] != null ? map['notion'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notion.fromJson(String source) => Notion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Notion(id: $id, notion: $notion, text: $text)';

  @override
  bool operator ==(covariant Notion other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.notion == notion &&
      other.text == text;
  }

  @override
  int get hashCode => id.hashCode ^ notion.hashCode ^ text.hashCode;
}
