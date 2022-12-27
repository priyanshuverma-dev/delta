import 'dart:convert';

Bot botFromJson(String str) => Bot.fromJson(json.decode(str));

String botToJson(Bot data) => json.encode(data.toJson());

class Bot {
  Bot({
    required this.bot,
  });

  String bot;

  factory Bot.fromJson(Map<String, dynamic> json) => Bot(
        bot: json["bot"],
      );

  Map<String, dynamic> toJson() => {
        "bot": bot,
      };
}
