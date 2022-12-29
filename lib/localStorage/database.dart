import 'package:answer_it/localStorage/models/dataModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  static Box<BotData> getBotData() => Hive.box<BotData>('BotBox');
  static Box<UserData> getUserData() => Hive.box<UserData>('UserBox');
}
