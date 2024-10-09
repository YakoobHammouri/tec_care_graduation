class UserField {
  static const String lastMessageTime = 'lastMessageTime';
}

class ChatUser {
  final String id;
  final String name;

  const ChatUser({
    required this.id,
    required this.name,
  });

  ChatUser copyWith({
    required String id,
    required String name,
  }) =>
      ChatUser(
        id: id,
        name: name,
      );

  static ChatUser fromJson(Map<String, dynamic> json) => ChatUser(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
