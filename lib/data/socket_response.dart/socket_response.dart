// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SocketResponse {
  String? type;
  String? message;
  SocketResponse({
    this.type,
    this.message,
  });

  SocketResponse copyWith({
    String? type,
    String? message,
  }) {
    return SocketResponse(
      type: type ?? this.type,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'message': message,
    };
  }

  factory SocketResponse.fromMap(Map<String, dynamic> map) {
    return SocketResponse(
      type: map['type'] != null ? map['type'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketResponse.fromJson(String source) => SocketResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SocketResponse(type: $type, message: $message)';

  @override
  bool operator ==(covariant SocketResponse other) {
    if (identical(this, other)) return true;

    return other.type == type && other.message == message;
  }

  @override
  int get hashCode => type.hashCode ^ message.hashCode;
}
