// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Daily {
  final String content;
  final String title;
  final String image;
  Daily({
    required this.content,
    required this.title,
    required this.image,
  });

  Daily copyWith({
    String? content,
    String? title,
    String? image,
  }) {
    return Daily(
      content: content ?? this.content,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'title': title,
      'image': image,
    };
  }

  factory Daily.fromMap(Map<String, dynamic> map) {
    return Daily(
      content: map['content'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Daily.fromJson(String source) =>
      Daily.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Daily(content: $content, title: $title, image: $image)';

  @override
  bool operator ==(covariant Daily other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.title == title &&
        other.image == image;
  }

  @override
  int get hashCode => content.hashCode ^ title.hashCode ^ image.hashCode;
}
