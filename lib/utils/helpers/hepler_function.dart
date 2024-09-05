import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';

class HeplerFunction {
  static Color getRoleColor(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.Developer:
        return Colors.teal;
      case EmployeeRole.Support:
        return const Color.fromRGBO(254, 112, 102, 1);
      case EmployeeRole.Sale:
        return Colors.orange;
      case EmployeeRole.Hr:
        return Colors.deepPurpleAccent;
      default:
        return Colors.blue;
    }
  }

  static String convertRole(String value) {
    switch (value) {
      case "1":
        {
          return EmployeeRole.Developer.name.toString();
        }
      case "2":
        {
          return EmployeeRole.Sale.name.toString();
        }
      default:
        return EmployeeRole.Support.name.toString();
    }
  }

  static String convertEnumToInt(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.Developer:
        return "1";
      case EmployeeRole.Sale:
        return "2";
      default:
        return "3";
    }
  }

  static EmployeeRole convertToEnum(String value) {
    switch (value) {
      case "1":
        {
          return EmployeeRole.Developer;
        }
      case "2":
        {
          return EmployeeRole.Sale;
        }
      default:
        return EmployeeRole.Support;
    }
  }

  static double calculateWeekdays(DateTime startDate, DateTime endDate) {
  int totalWeekdays = 0;
  DateTime currentDate = startDate;

  while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
    if (currentDate.weekday != DateTime.saturday && currentDate.weekday != DateTime.sunday) {
      totalWeekdays++;
    }
    // Chuyển sang ngày tiếp theo
    currentDate = currentDate.add(Duration(days: 1));
  }

  return totalWeekdays.toDouble();
}

  
}
