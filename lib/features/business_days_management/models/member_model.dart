import 'package:hrm_aqtech/data/employees/employee_repository.dart';

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

  Future<String> getNameById() async {
    final employee =
        await EmployeeRepository.instance.getAssignedEmployeeList();
    return employee.firstWhere((a) => a.id == id).fullName;
  }
}
