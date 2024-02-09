/// A model for a course's information
class CourseDetail {
  final int _id;
  final String _name;
  final String _description;

  const CourseDetail(this._id, this._name, this._description);

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get description {
    return _description;
  }
}
