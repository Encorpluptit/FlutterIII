import 'package:cloud_firestore/cloud_firestore.dart';

class NewsData {
    String? _id;
    /* String? _user; */
    Timestamp? _createdAt;
    String _title = "";
    String _content = "";
    List<String> _groups = [];

    NewsData(data, docId) {
        _id = docId;
        /* _user = data["user"]; */
        _createdAt = data["created_at"];
        _title = data["title"];
        _content = data["content"];
        _groups = data["groups"];
    }

    String? get id => _id;
    Timestamp? get createdAt => _createdAt;
    String get title => _title;
    String get content => _content;
    List<String>? get groups => _groups;
}
