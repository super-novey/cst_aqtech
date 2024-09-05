import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class OnlineWork {
  int id;
  DateTime dateFrom;
  DateTime dateTo;
  double sumDay;
  int memberId;
  String reason;
  bool isAnnual;
  bool isWithoutPay;
  ApprovalStatus approvalStatus;
  String note;

  OnlineWork({
    this.id = 0,
    DateTime? dateFrom,
    DateTime? dateTo,
    this.sumDay = 0,
    this.memberId = 0,
    this.reason = "",
    this.isAnnual = false,
    this.isWithoutPay = false,
    this.approvalStatus = ApprovalStatus.pending,
    this.note = "",
  })  : dateFrom = dateFrom ?? DateTime.now(),
        dateTo = dateTo ?? DateTime.now();

  // Phương thức fromJson để parse dữ liệu JSON thành model
  factory OnlineWork.fromJson(Map<String, dynamic> json) {
    return OnlineWork(
      id: json['id'] ?? 0,
      dateFrom: DateTime.parse(json['dateFrom']),
      dateTo: DateTime.parse(json['dateTo']),
      sumDay: (json['sumDay'] ?? 0).toDouble(), // Chuyển đổi thành double
      memberId: json['memberId'] ?? 0,
      reason: json['reason'] ?? "",
      isAnnual: json['isAnnual'] ?? false,
      isWithoutPay: json['isWithoutPay'] ?? false,
      approvalStatus: HeplerFunction.convertStatusToEnum(json['approvalStatus'] ?? ""),
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
      'memberId': memberId,
      'reason': reason,
      'isAnnual': isAnnual,
      'isWithoutPay': isWithoutPay,
      'approvalStatus': HeplerFunction.convertEnumToString(approvalStatus),
      'note': note,
    };
  }
}
