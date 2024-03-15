/// A model for a lesson's information
class LessonDetail {
  final int _tacticId;
  final int _lessonId;
  final int averageDifficulty;

  const LessonDetail(this._tacticId, this._lessonId, this.averageDifficulty);

  int get tacticId {
    return _tacticId;
  }

  int get lessonId {
    return _lessonId;
  }

  int get difficulty {
    return averageDifficulty;
  }
}
