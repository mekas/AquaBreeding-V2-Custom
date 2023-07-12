import 'package:intl/intl.dart';

class FeedHistoryHourly {
  DateTime? date;
  num? totalFeedWeight;
  String? brandName;

  FeedHistoryHourly({
    required this.date,
    required this.totalFeedWeight,
    required this.brandName,
  });

  factory FeedHistoryHourly.fromJson(Map<String, dynamic> json) {
    return FeedHistoryHourly(
      date: DateTime.tryParse(json['feed_history_time']),
      totalFeedWeight: json['feed_dose'],
      brandName: json['feed']['brand_name'],
    );
  }

  static List<FeedHistoryHourly> fromJsonList(List<dynamic> list) {
    List<FeedHistoryHourly> feedHistorys = [];
    for (var item in list) {
      feedHistorys.add(FeedHistoryHourly.fromJson(item));
    }
    return feedHistorys;
  }

  String getDate() => DateFormat('dd-MM-yyyy ').format(date!);
  String getTime() => DateFormat.Hm().format(date!);
}
