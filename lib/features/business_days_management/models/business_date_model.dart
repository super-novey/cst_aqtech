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
    required this.id,
    required this.dateFrom,
    required this.dateTo,
    required this.sumDay,
    required this.commissionContent,
    required this.transportation,
    required this.memberList,
    required this.commissionExpenses,
    required this.note,
  });

  factory BusinessDate.fromJson(Map<String, dynamic> json) {
    return BusinessDate(
      id: json['id'],
      dateFrom: DateTime.parse(json['dateFrom']),
      dateTo: DateTime.parse(json['dateTo']),
      sumDay: json['sumDay'].toDouble(),
      commissionContent: json['comissionContent'],
      transportation: json['transportation'],
      memberList: (json['memberList'] as List)
          .map((member) => Member.fromJson(member))
          .toList(),
      commissionExpenses: json['commissionExpenses'],
      note: json['note'],
    );
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