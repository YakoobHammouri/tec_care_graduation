import '../utils.dart';

class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  final String id;
  final String name;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.name,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        id: json['id'],
        name: json['name'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt'])!,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
