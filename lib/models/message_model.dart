import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class MessageModel {
  final String? message;
  final String? sendName;
  final String? dateMessage;

  const MessageModel({this.message, this.sendName, this.dateMessage});

  @override
  String toString() {
    return 'MessageModel(message: $message, sendName: $sendName, dateMessage: $dateMessage)';
  }

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      message: data['message'] as String?,
      sendName: data['send_name'] as String?,
      dateMessage: data['dateMessage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'send_name': sendName,
      'dateMessage': dateMessage,
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MessageModel].
  factory MessageModel.fromJson(String data) {
    return MessageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MessageModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MessageModel copyWith({
    String? message,
    String? sendName,
    String? dateMessage,
  }) {
    return MessageModel(
      message: message ?? this.message,
      sendName: sendName ?? this.sendName,
      dateMessage: dateMessage ?? this.dateMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MessageModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      message.hashCode ^ sendName.hashCode ^ dateMessage.hashCode;
}
