import 'package:intl/intl.dart';

String formatTopicTime(int topicId) {
  DateTime topicTime = DateTime.fromMillisecondsSinceEpoch(topicId);

  DateTime now = DateTime.now();
  DateTime todayStart = DateTime(now.year, now.month, now.day);
  DateTime yesterdayStart = todayStart.subtract(const Duration(days: 1));

  // 오늘 날짜일 경우 시간만 표시
  if (topicTime.isAfter(todayStart)) {
    return DateFormat('a hh:mm', 'ko_KR').format(topicTime);
  }

  // 어제 날짜일 경우 "어제"로 표시
  if (topicTime.isAfter(yesterdayStart)) {
    return '어제';
  }
  return DateFormat('M월 d일', 'ko').format(topicTime);
}

String formatTopic(int topicId) {
  DateTime topicTime = DateTime.fromMillisecondsSinceEpoch(topicId);
  return DateFormat('a hh:mm', 'ko_KR').format(topicTime);
}