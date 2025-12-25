import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "coursesEnrolled" field.
  List<CoursesEnrolledStruct>? _coursesEnrolled;
  List<CoursesEnrolledStruct> get coursesEnrolled =>
      _coursesEnrolled ?? const [];
  bool hasCoursesEnrolled() => _coursesEnrolled != null;

  // "semesterID" field.
  String? _semesterID;
  String get semesterID => _semesterID ?? '';
  bool hasSemesterID() => _semesterID != null;

  // "batchID" field.
  String? _batchID;
  String get batchID => _batchID ?? '';
  bool hasBatchID() => _batchID != null;

  // "studentIDCard" field.
  String? _studentIDCard;
  String get studentIDCard => _studentIDCard ?? '';
  bool hasStudentIDCard() => _studentIDCard != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "userBio" field.
  String? _userBio;
  String get userBio => _userBio ?? '';
  bool hasUserBio() => _userBio != null;

  // "userRole" field.
  String? _userRole;
  String get userRole => _userRole ?? '';
  bool hasUserRole() => _userRole != null;

  // "lastDataFetchTime" field.
  DateTime? _lastDataFetchTime;
  DateTime? get lastDataFetchTime => _lastDataFetchTime;
  bool hasLastDataFetchTime() => _lastDataFetchTime != null;

  // "currentStreak" field.
  int? _currentStreak;
  int get currentStreak => _currentStreak ?? 0;
  bool hasCurrentStreak() => _currentStreak != null;

  // "longestStreak" field.
  int? _longestStreak;
  int get longestStreak => _longestStreak ?? 0;
  bool hasLongestStreak() => _longestStreak != null;

  // "amplix" field.
  int? _amplix;
  int get amplix => _amplix ?? 0;
  bool hasAmplix() => _amplix != null;

  // "streakHistory" field.
  List<int>? _streakHistory;
  List<int> get streakHistory => _streakHistory ?? const [];
  bool hasStreakHistory() => _streakHistory != null;

  // "challengesAllotted" field.
  List<ChallengeStruct>? _challengesAllotted;
  List<ChallengeStruct> get challengesAllotted =>
      _challengesAllotted ?? const [];
  bool hasChallengesAllotted() => _challengesAllotted != null;

  // "challengeKey" field.
  String? _challengeKey;
  String get challengeKey => _challengeKey ?? '';
  bool hasChallengeKey() => _challengeKey != null;

  // "honorScore" field.
  int? _honorScore;
  int get honorScore => _honorScore ?? 0;
  bool hasHonorScore() => _honorScore != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _coursesEnrolled = getStructList(
      snapshotData['coursesEnrolled'],
      CoursesEnrolledStruct.fromMap,
    );
    _semesterID = snapshotData['semesterID'] as String?;
    _batchID = snapshotData['batchID'] as String?;
    _studentIDCard = snapshotData['studentIDCard'] as String?;
    _username = snapshotData['username'] as String?;
    _userBio = snapshotData['userBio'] as String?;
    _userRole = snapshotData['userRole'] as String?;
    _lastDataFetchTime = snapshotData['lastDataFetchTime'] as DateTime?;
    _currentStreak = castToType<int>(snapshotData['currentStreak']);
    _longestStreak = castToType<int>(snapshotData['longestStreak']);
    _amplix = castToType<int>(snapshotData['amplix']);
    _streakHistory = getDataList(snapshotData['streakHistory']);
    _challengesAllotted = getStructList(
      snapshotData['challengesAllotted'],
      ChallengeStruct.fromMap,
    );
    _challengeKey = snapshotData['challengeKey'] as String?;
    _honorScore = castToType<int>(snapshotData['honorScore']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? semesterID,
  String? batchID,
  String? studentIDCard,
  String? username,
  String? userBio,
  String? userRole,
  DateTime? lastDataFetchTime,
  int? currentStreak,
  int? longestStreak,
  int? amplix,
  String? challengeKey,
  int? honorScore,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'semesterID': semesterID,
      'batchID': batchID,
      'studentIDCard': studentIDCard,
      'username': username,
      'userBio': userBio,
      'userRole': userRole,
      'lastDataFetchTime': lastDataFetchTime,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'amplix': amplix,
      'challengeKey': challengeKey,
      'honorScore': honorScore,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        listEquality.equals(e1?.coursesEnrolled, e2?.coursesEnrolled) &&
        e1?.semesterID == e2?.semesterID &&
        e1?.batchID == e2?.batchID &&
        e1?.studentIDCard == e2?.studentIDCard &&
        e1?.username == e2?.username &&
        e1?.userBio == e2?.userBio &&
        e1?.userRole == e2?.userRole &&
        e1?.lastDataFetchTime == e2?.lastDataFetchTime &&
        e1?.currentStreak == e2?.currentStreak &&
        e1?.longestStreak == e2?.longestStreak &&
        e1?.amplix == e2?.amplix &&
        listEquality.equals(e1?.streakHistory, e2?.streakHistory) &&
        listEquality.equals(e1?.challengesAllotted, e2?.challengesAllotted) &&
        e1?.challengeKey == e2?.challengeKey &&
        e1?.honorScore == e2?.honorScore;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.coursesEnrolled,
        e?.semesterID,
        e?.batchID,
        e?.studentIDCard,
        e?.username,
        e?.userBio,
        e?.userRole,
        e?.lastDataFetchTime,
        e?.currentStreak,
        e?.longestStreak,
        e?.amplix,
        e?.streakHistory,
        e?.challengesAllotted,
        e?.challengeKey,
        e?.honorScore
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
