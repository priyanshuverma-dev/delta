import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.message,
  });

  String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
