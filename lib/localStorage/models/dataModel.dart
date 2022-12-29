import 'package:hive/hive.dart';

part 'dataModel.g.dart';

@HiveType(typeId: 0)
class BotData extends HiveObject {
  BotData({required this.anwser, required this.id});
  @HiveField(0)
  String anwser;

  @HiveField(1)
  int id;
}

@HiveType(typeId: 1)
class UserData extends HiveObject {
  UserData({required this.question, required this.id});
  @HiveField(0)
  String question;

  @HiveField(1)
  int id;
}
