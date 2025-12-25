import '../database.dart';

class AmplixChallengeProgressTable
    extends SupabaseTable<AmplixChallengeProgressRow> {
  @override
  String get tableName => 'amplixChallengeProgress';

  @override
  AmplixChallengeProgressRow createRow(Map<String, dynamic> data) =>
      AmplixChallengeProgressRow(data);
}

class AmplixChallengeProgressRow extends SupabaseDataRow {
  AmplixChallengeProgressRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AmplixChallengeProgressTable();

  String get progressID => getField<String>('progressID')!;
  set progressID(String value) => setField<String>('progressID', value);

  String get userID => getField<String>('userID')!;
  set userID(String value) => setField<String>('userID', value);

  String get challengeID => getField<String>('challengeID')!;
  set challengeID(String value) => setField<String>('challengeID', value);

  String get idempotentKey => getField<String>('idempotentKey')!;
  set idempotentKey(String value) => setField<String>('idempotentKey', value);

  String get challengeType => getField<String>('challengeType')!;
  set challengeType(String value) => setField<String>('challengeType', value);

  int get progress => getField<int>('progress')!;
  set progress(int value) => setField<int>('progress', value);

  int get targetValue => getField<int>('targetValue')!;
  set targetValue(int value) => setField<int>('targetValue', value);

  bool get isCompleted => getField<bool>('isCompleted')!;
  set isCompleted(bool value) => setField<bool>('isCompleted', value);

  DateTime? get completionDate => getField<DateTime>('completionDate');
  set completionDate(DateTime? value) =>
      setField<DateTime>('completionDate', value);

  List<String> get completedWithClassIDs =>
      getListField<String>('completedWithClassIDs');
  set completedWithClassIDs(List<String> value) =>
      setListField<String>('completedWithClassIDs', value);

  DateTime get lastUpdated => getField<DateTime>('lastUpdated')!;
  set lastUpdated(DateTime value) => setField<DateTime>('lastUpdated', value);

  bool? get isClaimed => getField<bool>('isClaimed');
  set isClaimed(bool? value) => setField<bool>('isClaimed', value);
}
