class Member {
  int id;
  int memberExpenses;

  Member({
    required this.id,
    required this.memberExpenses,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      memberExpenses: json['memberExpenses'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberExpenses': memberExpenses,
    };
  }
}