import 'package:hrm_aqtech/features/business_days_management/models/member_model.dart';

class BusinessDate {
  int id;
  DateTime dateFrom;
  DateTime dateTo;
  double sumDay;
  String commissionContent;
  String transportation;
  List<Member> memberList;
  int commissionExpenses;
  String note;

  BusinessDate({
    this.id = 0,
    DateTime? dateFrom,
    DateTime? dateTo,
    this.sumDay = 1.0,
    this.commissionContent = "",
    this.transportation = "",
    this.memberList = const [],
    this.commissionExpenses = 0,
    this.note = "",
  })  : dateTo = dateTo ?? DateTime.now(),
        dateFrom = dateFrom ?? DateTime.now();

  factory BusinessDate.fromJson(Map<String, dynamic> json) {
    return BusinessDate(
      id: json['id'],
      dateFrom: DateTime.parse(json['dateFrom']),
      dateTo: DateTime.parse(json['dateTo']),
      sumDay: json['sumDay'].toDouble(),
      commissionContent: json['comissionContent'] ?? "",
      transportation: json['transportation'] ?? "",
      memberList: (json['memberList'] as List)
          .map((member) => Member.fromJson(member))
          .toList(),
      commissionExpenses: json['commissionExpenses'],
      note: json['note'] ?? "",
    );
  }
  int countWeekdays(DateTime startDate, DateTime endDate) {
    int weekdayCount = 0;
    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday != DateTime.saturday &&
          currentDate.weekday != DateTime.sunday) {
        weekdayCount++;
      }
      currentDate = currentDate.add(Duration(days: 1));
    }

    return weekdayCount;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateFrom': dateFrom.toIso8601String(),
      'dateTo': dateTo.toIso8601String(),
      'sumDay': sumDay,
      'comissionContent': commissionContent,
      'transportation': transportation,
      'memberList': memberList.map((member) => member.toJson()).toList(),
      'commissionExpenses': commissionExpenses,
      'note': note,
    };
  }
}
