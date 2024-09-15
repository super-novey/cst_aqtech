class OverTimeStatistic {
  String nickName;
  String fullName;
  double sumHours;

  OverTimeStatistic({
    required this.nickName,
    required this.fullName,
    required this.sumHours,
  });

  // Factory method to create an OverTime object from JSON
  factory OverTimeStatistic.fromJson(Map<String, dynamic> json) {
    return OverTimeStatistic(
      nickName: json['nickName'],
      fullName: json['fullName'],
      sumHours: double.parse(json['sumHours'].toString()),
    );
  }
}
