import '../database.dart';

class ChallengeTemplatesTable extends SupabaseTable<ChallengeTemplatesRow> {
  @override
  String get tableName => 'challengeTemplates';

  @override
  ChallengeTemplatesRow createRow(Map<String, dynamic> data) =>
      ChallengeTemplatesRow(data);
}

class ChallengeTemplatesRow extends SupabaseDataRow {
  ChallengeTemplatesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ChallengeTemplatesTable();

  String get challengeID => getField<String>('challengeID')!;
  set challengeID(String value) => setField<String>('challengeID', value);

  String get challengeName => getField<String>('challengeName')!;
  set challengeName(String value) => setField<String>('challengeName', value);

  String get challengeDescription => getField<String>('challengeDescription')!;
  set challengeDescription(String value) =>
      setField<String>('challengeDescription', value);

  String get challengeType => getField<String>('challengeType')!;
  set challengeType(String value) => setField<String>('challengeType', value);

  String get challengeCondition => getField<String>('challengeCondition')!;
  set challengeCondition(String value) =>
      setField<String>('challengeCondition', value);

  int? get targetValue => getField<int>('targetValue');
  set targetValue(int? value) => setField<int>('targetValue', value);

  List<String> get dependentChallengeIDs =>
      getListField<String>('dependentChallengeIDs');
  set dependentChallengeIDs(List<String>? value) =>
      setListField<String>('dependentChallengeIDs', value);

  bool get isActive => getField<bool>('isActive')!;
  set isActive(bool value) => setField<bool>('isActive', value);

  DateTime get createdAt => getField<DateTime>('createdAt')!;
  set createdAt(DateTime value) => setField<DateTime>('createdAt', value);

  DateTime get updatedAt => getField<DateTime>('updatedAt')!;
  set updatedAt(DateTime value) => setField<DateTime>('updatedAt', value);

  int get amplixReward => getField<int>('amplixReward')!;
  set amplixReward(int value) => setField<int>('amplixReward', value);
}
