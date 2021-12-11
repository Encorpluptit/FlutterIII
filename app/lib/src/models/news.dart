import 'package:cloud_firestore/cloud_firestore.dart';

class NewsData {
  String? _id;
  Timestamp? _createdAt;
  String? _title;
  String? _content;
  List<dynamic>? _groups;

  NewsData(data, docId) {
    _id = docId;
    _createdAt = data["created_at"];
    _title = data["title"];
    _content = data["content"];
    print("groups type:");
    print(data["groups"].runtimeType);
    _groups = data["groups"];
  }

  String? get id => _id;
  Timestamp? get createdAt => _createdAt;
  String? get title => _title;
  String? get content => _content;
  List<dynamic>? get groups => _groups;
}
