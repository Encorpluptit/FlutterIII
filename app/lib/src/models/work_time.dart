class WorkTime {
  String _id = "";
  String _user = "";
  DateTime _createdAt = DateTime.now();
  DateTime _updatedAt = DateTime.now();
  DateTime _in = DateTime.now();
  DateTime _out = DateTime.now();
  double _inLatitude = 0;
  double _inLongitude = 0;
  double _outLatitude = 0;
  double _outLongitude = 0;

  WorkTime(data, docId) {
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
  }

  String get id => _id;
  String get user => _user;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  DateTime get in_ => _in;
  DateTime get out => _out;
  double get inLatitude => _inLatitude;
  double get inLongitude => _inLongitude;
  double get outLatitude => _outLatitude;
  double get outLongitude => _outLongitude;
}
