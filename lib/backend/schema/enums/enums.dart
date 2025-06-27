import 'package:collection/collection.dart';

enum TaskType {
  assignment,
  exam,
}

enum StudyMaterialType {
  folder,
  file,
}

enum ChallengeType {
  weekly,
  monthly,
  semester,
}

enum RecordType {
  timetableRecord,
  attendanceRecord,
  assignment,
  exam,
  course,
  customClass,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (TaskType):
      return TaskType.values.deserialize(value) as T?;
    case (StudyMaterialType):
      return StudyMaterialType.values.deserialize(value) as T?;
    case (ChallengeType):
      return ChallengeType.values.deserialize(value) as T?;
    case (RecordType):
      return RecordType.values.deserialize(value) as T?;
    default:
      return null;
  }
}
