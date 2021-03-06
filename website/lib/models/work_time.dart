import 'package:cloud_firestore/cloud_firestore.dart';

class WorkTimeModel {
  String? _id;
  String? _user;
  Timestamp? _createdAt;
  Timestamp? _updatedAt;
  Timestamp? _in;
  Timestamp? _out;
  double? _inLatitude;
  double? _inLongitude;
  double? _outLatitude;
  double? _outLongitude;
  bool? _requiresApproval;

  WorkTimeModel(data, docId) {
    _id = docId;
    _user = data["user"];
    _createdAt = data["created_at"];
    _updatedAt = data["updated_at"];
    _in = data["in"];
    _out = data["out"];
    _inLatitude = data["in_latitude"];
    _inLongitude = data["in_longitude"];
    _outLatitude = data["out_latitude"];
    _outLongitude = data["out_longitude"];
    _outLongitude = data["out_longitude"];
    _requiresApproval = data["requires_approval"];
  }

  String? get id => _id;
  String? get user => _user;
  Timestamp? get createdAt => _createdAt;
  Timestamp? get updatedAt => _updatedAt;
  Timestamp? get in_ => _in;
  Timestamp? get out => _out;
  double? get inLatitude => _inLatitude;
  double? get inLongitude => _inLongitude;
  double? get outLatitude => _outLatitude;
  double? get outLongitude => _outLongitude;
  bool? get requiresApproval => _requiresApproval;

  set in_(value) => _in = value;
  set out(value) => _out = value;
  set requiresApproval(value) => _requiresApproval = value;
}
