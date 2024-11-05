import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
      final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
      return isAfter && isBefore;
    }
    return null;
  }

  DateTime getDateOnly() {
    return DateTime(this!.year, this!.month, this!.day);
  }

  bool isSameDay(DateTime other) {
    return this!.year == other.year && this!.month == other.month && this!.day == other.day;
  }

  bool isAfterThisMoment(DateTime other) {
    final date = this;

    if (date!.isBefore(other)) return false;

    if (date.isSameDay(other)) {
      if (date.hour < other.hour) return false;
      if (date.hour == other.hour) {
        if (date.minute < other.minute) return false;
        if (date.minute == other.minute) {
          if (date.second < other.second) return false;
          return true;
        }
        return true;
      }
      return true;
    }

    return true;
  }

  String get formatDate {
    return '${this!.day.toString().padLeft(2, '0')}'
        ' ${DateFormat.MMMM('pt').format(this!).substring(0, 3).toUpperCase()}';
  }

  String get formatTime {
    return DateFormat.Hm('pt').format(this!);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }

  bool isBefore(TimeOfDay other) {
    if (hour == other.hour && minute == other.minute) return true;
    if (hour < other.hour) return true;
    if (hour > other.hour) return false;
    if (minute < other.minute) return true;
    if (minute > other.minute) return false;
    return false;
  }

  bool isAfter2(TimeOfDay other) {
    if (hour == other.hour && minute == other.minute) return true;
    if (hour < other.hour) return false;
    if (hour > other.hour) return true;
    if (minute < other.minute) return false;
    if (minute > other.minute) return true;
    return false;
  }

  bool isSame(TimeOfDay other) => hour == other.hour && minute == other.minute;

  TimeOfDay add({int hour = 0, int minute = 0}) {
    return replacing(hour: this.hour + hour, minute: this.minute + minute);
  }

  String get toStringFormat {
    var time = this;
    return '${_twoDigits(time.hour)}:${_twoDigits(time.minute)}';
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}

extension DurationExtensions on Duration {
  /// Converts the duration into a readable string
  /// 05:15
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return "${inHours}H$twoDigitMinutes";
  }

  /// Converts the duration into a readable string
  /// 05:15:35
  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
