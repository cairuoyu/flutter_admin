class TaskStatisticalModel {
  String? timeName;
  int? upcomingCount;
  int? inProgressCount;
  int? doneCount;
  int? finishCount;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  TaskStatisticalModel({
    this.timeName,
    this.upcomingCount,
    this.inProgressCount,
    this.doneCount,
    this.finishCount,
  });

  TaskStatisticalModel copyWith({
    String? timeName,
    int? upcomingCount,
    int? inProgressCount,
    int? doneCount,
    int? finishCount,
  }) {
    return new TaskStatisticalModel(
      timeName: timeName ?? this.timeName,
      upcomingCount: upcomingCount ?? this.upcomingCount,
      inProgressCount: inProgressCount ?? this.inProgressCount,
      doneCount: doneCount ?? this.doneCount,
      finishCount: finishCount ?? this.finishCount,
    );
  }

  @override
  String toString() {
    return 'TaskStatisticalModel{timeName: $timeName, upcomingCount: $upcomingCount, inProgressCount: $inProgressCount, doneCount: $doneCount, finishCount: $finishCount}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskStatisticalModel &&
          runtimeType == other.runtimeType &&
          timeName == other.timeName &&
          upcomingCount == other.upcomingCount &&
          inProgressCount == other.inProgressCount &&
          doneCount == other.doneCount &&
          finishCount == other.finishCount);

  @override
  int get hashCode => timeName.hashCode ^ upcomingCount.hashCode ^ inProgressCount.hashCode ^ doneCount.hashCode ^ finishCount.hashCode;

  factory TaskStatisticalModel.fromMap(Map<String, dynamic> map) {
    return new TaskStatisticalModel(
      timeName: map['timeName'] as String?,
      upcomingCount: map['upcomingCount'] as int?,
      inProgressCount: map['inProgressCount'] as int?,
      doneCount: map['doneCount'] as int?,
      finishCount: map['finishCount'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'timeName': this.timeName,
      'upcomingCount': this.upcomingCount,
      'inProgressCount': this.inProgressCount,
      'doneCount': this.doneCount,
      'finishCount': this.finishCount,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
