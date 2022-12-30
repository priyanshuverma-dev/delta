import 'package:hive/hive.dart';

part 'pvtalk.g.dart';

@HiveType(typeId: 1)
class PvTalk extends HiveObject {
  PvTalk({
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.id,
  });
  @HiveField(0)
  String question;

  @HiveField(1)
  String answer;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  int id;
}
