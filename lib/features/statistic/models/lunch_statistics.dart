class LunchStatistics {
  final int id;
  final String fullName;
  final String nickName;
  final int totalIndividualDayOff;
  final int totalWorkingOnline;
  final int totalCommissionDay;
  final int totalAQDayOff;

  LunchStatistics({
    required this.id,
    required this.fullName,
    required this.nickName,
    required this.totalIndividualDayOff,
    required this.totalWorkingOnline,
    required this.totalCommissionDay,
    required this.totalAQDayOff,
  });

  factory LunchStatistics.fromJson(Map<String, dynamic> json) {
    return LunchStatistics(
      id: json['id'],
      fullName: json['fullName'],
      nickName: json['nickName'],
      totalIndividualDayOff: json['total_IndividualDayOff'],
      totalWorkingOnline: json['total_WorkingOnline'],
      totalCommissionDay: json['total_CommissionDay'],
      totalAQDayOff: json['total_AQDayOff'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'nickName': nickName,
      'total_IndividualDayOff': totalIndividualDayOff,
      'total_WorkingOnline': totalWorkingOnline,
      'total_CommissionDay': totalCommissionDay,
      'total_AQDayOff': totalAQDayOff,
    };
  }
}

class LunchStatisticsResponse {
  final List<LunchStatistics> data;
  final bool result;
  final int code;
  final String message;

  LunchStatisticsResponse({
    required this.data,
    required this.result,
    required this.code,
    required this.message,
  });

  factory LunchStatisticsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<LunchStatistics> dataList =
        list.map((i) => LunchStatistics.fromJson(i)).toList();

    return LunchStatisticsResponse(
      data: dataList,
      result: json['result'],
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'result': result,
      'code': code,
      'message': message,
    };
  }
}
