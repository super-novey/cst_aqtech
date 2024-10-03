class CommissionDay {
  final int id;
  final String fullName;
  final String nickName;
  final int totalCommissionDay;
  final int totalCommissionPayment;

  CommissionDay({
    required this.id,
    required this.fullName,
    required this.nickName,
    required this.totalCommissionDay,
    required this.totalCommissionPayment,
  });

  // Factory method to parse JSON into a CommissionDay object
  factory CommissionDay.fromJson(Map<String, dynamic> json) {
    return CommissionDay(
      id: json['id'],
      fullName: json['fullName'] ?? "",
      nickName: json['nickName'] ?? "",
      totalCommissionDay: json['total_CommissionDay'],
      totalCommissionPayment: json['total_CommissionPayment'],
    );
  }

  // Method to convert a CommissionDay object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'nickName': nickName,
      'total_CommissionDay': totalCommissionDay,
      'total_CommissionPayment': totalCommissionPayment,
    };
  }
}
