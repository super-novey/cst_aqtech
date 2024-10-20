import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/helpers/helper_function.dart';

class LeaveDay {
  int id;
  DateTime dateFrom;
  DateTime dateTo;
  double sumDay;
  int numberOfDayWhole;
  int numberOfDayHalf;
  int memberId;
  String reason;
  bool isAnnual;
  int totalIsAnnual;
  bool isWithoutPay;
  int totalIsWithoutPay;
  ApprovalStatus approvalStatus;
  String note;

  // "id": "<integer>",
  //     "dateFrom": "<dateTime>",
  //     "dateTo": "<dateTime>",
  //     "sumDay": "<float>",
  //     "numberOfDay_whole": "<integer>",**
  //     "numberOfDay_half": "<integer>",**
  //     "memberId": "<integer>",
  //     "reason": "<string>",
  //     "isAnnual": "<boolean>",
  //     "totalIsAnnual": "<integer>",*
  //     "isWithoutPay": "<boolean>",
  //     "totalIsWithoutPay": "<integer>",*
  //     "approvalStatus": "<string>",
  //     "note": "<string>"

  LeaveDay({
    this.id = 0,
    DateTime? dateFrom,
    DateTime? dateTo,
    this.sumDay = 0,
    this.numberOfDayWhole = 0,
    this.numberOfDayHalf = 0,
    this.memberId = 0,
    this.reason = "",
    this.isAnnual = false,
    this.totalIsAnnual = 0,
    this.totalIsWithoutPay = 0,
    this.isWithoutPay = false,
    this.approvalStatus = ApprovalStatus.pending,
    this.note = "",
  })  : dateFrom = dateFrom ?? DateTime.now(),
        dateTo = dateTo ?? DateTime.now();

  // Phương thức fromJson để parse dữ liệu JSON thành model
  factory LeaveDay.fromJson(Map<String, dynamic> json) {
    return LeaveDay(
      id: json['id'] ?? 0,
      dateFrom: DateTime.parse(json['dateFrom']),
      dateTo: DateTime.parse(json['dateTo']),
      sumDay: (json['sumDay'] ?? 0).toDouble(), // Chuyển đổi thành double
      numberOfDayWhole: json['numberOfDay_whole'] ?? 0,
      numberOfDayHalf: json['numberOfDay_half'] ?? 0,
      memberId: json['memberId'] ?? 0,
      reason: json['reason'] ?? "",
      isAnnual: json['isAnnual'] ?? false,
      totalIsAnnual: json['totalIsAnnual'] ?? 0,
      isWithoutPay: json['isWithoutPay'] ?? false,
      totalIsWithoutPay: json['totalIsWithoutPay'] ?? 0,
      approvalStatus:
          HeplerFunction.convertStatusToEnum(json['approvalStatus'] ?? ""),
      note: json['note'] ?? "",
    );
  }

  // Phương thức toJson để chuyển đổi model thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateFrom': dateFrom.toIso8601String(),
      'dateTo': dateTo.toIso8601String(),
      'sumDay': sumDay,
      'numberOfDay_whole': numberOfDayWhole,
      'numberOfDay_half': numberOfDayHalf,
      'memberId': memberId,
      'reason': reason,
      'isAnnual': isAnnual,
      'totalIsAnnual': totalIsAnnual,
      'isWithoutPay': isWithoutPay,
      'totalIsWithoutPay': totalIsWithoutPay,
      'approvalStatus': HeplerFunction.convertEnumToString(approvalStatus),
      'note': note,
    };
  }
}
