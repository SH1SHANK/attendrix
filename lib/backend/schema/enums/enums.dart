import 'package:collection/collection.dart';

enum ClassStatus {
  isCancelled,
  isScheduled,
  isCompleted,
}

enum UserRole {
  student,
  admin,
  class_admin,
}

enum ClassListME02S2 {
  SolidMechanics,
  MaterialsScience,
  EngineeringGraphics,
  FluidMechanicsandMachinery,
  MathematicsII,
  ElectricalEngineering,
  ElectricalEngineeringLab,
}

enum Batch {
  ME02,
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
    case (ClassStatus):
      return ClassStatus.values.deserialize(value) as T?;
    case (UserRole):
      return UserRole.values.deserialize(value) as T?;
    case (ClassListME02S2):
      return ClassListME02S2.values.deserialize(value) as T?;
    case (Batch):
      return Batch.values.deserialize(value) as T?;
    default:
      return null;
  }
}
