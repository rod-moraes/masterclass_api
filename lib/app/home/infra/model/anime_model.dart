import 'dart:convert';
import 'package:intl/intl.dart';

class AnimeModel {
  final String id;
  final DateTime date;
  final String title;
  final String description;
  final String link;
  AnimeModel({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.link,
  });

  AnimeModel copyWith({
    String? id,
    DateTime? date,
    String? title,
    String? description,
    String? link,
  }) {
    return AnimeModel(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'description': description,
      'link': link,
    };
  }

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    final description = Bidi.stripHtmlIfNeeded(map['title']?['rendered'] ?? '');

    return AnimeModel(
      id: map['id']?.toString() ?? '',
      date: DateTime.parse(map['date']),
      title: map['title']?['rendered'] ?? '',
      description: description,
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeModel.fromJson(String source) =>
      AnimeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnimeModel(id: $id, date: $date, title: $title, description: $description, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimeModel &&
        other.id == id &&
        other.date == date &&
        other.title == title &&
        other.description == description &&
        other.link == link;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        title.hashCode ^
        description.hashCode ^
        link.hashCode;
  }
}
