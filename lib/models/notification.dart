import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class NotificationModel {
  final String? message;
  final String? dateNotif;
  final bool? isRead;
  final String? image;

  const NotificationModel(
      {this.message, this.dateNotif, this.isRead, this.image});

  @override
  String toString() {
    return 'Notification(message: $message, dateNotif: $dateNotif, isRead: $isRead, image: $image)';
  }

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    final DateTime dateTime = DateTime.parse(data['date_notif']);
    final DateFormat formatter = DateFormat('dd-MM-yyyy H:m');
    final String formatted = formatter.format(dateTime);
    return NotificationModel(
        message: data['message'] as String?,
        dateNotif: formatted,
        isRead: data['is_read'] as bool?,
        image: data['image'] as String?);
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'date_notif': dateNotif,
      'is_read': isRead,
      'image': image,
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotificationModel].
  factory NotificationModel.fromJson(String data) {
    return NotificationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NotificationModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NotificationModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => message.hashCode ^ dateNotif.hashCode ^ isRead.hashCode;
}
