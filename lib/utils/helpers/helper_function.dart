import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/aq_case_report_bar_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/case_progress_bar_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/case_waiting_time_bar_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/case_waiting_time_pie_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/dev_report_bar_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/sup_case_report_bar_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/sup_case_report_pie_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/time_distribution_bar_chart.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/work_progress_bar_chart.dart';
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
      case EmployeeRole.HR:
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

  static ApprovalStatus convertStatusToEnum(String status) {
    switch (status) {
      case "Đã duyệt":
        return ApprovalStatus.approved;
      case "Chưa duyệt":
        return ApprovalStatus.pending;
      case "Từ chối":
        return ApprovalStatus.rejected;
      default:
        return ApprovalStatus.pending;
    }
  }

  static String convertEnumToString(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.approved:
        return "Đã duyệt";
      case ApprovalStatus.pending:
        return "Chưa duyệt";
      case ApprovalStatus.rejected:
        return "Từ chối";
      default:
        return "Chưa duyệt";
    }
  }

  static Color getStatusColor(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.approved:
        return const Color.fromARGB(255, 62, 144, 65);
      case ApprovalStatus.rejected:
        return Colors.red;
      default:
        return const Color.fromARGB(255, 198, 129, 51);
    }
  }

  static EmployeeRole getRoleFromString(String role) {
    switch (role) {
      case 'Developer':
        return EmployeeRole.Developer;
      case 'Sale':
        return EmployeeRole.Sale;
      case 'BM':
        return EmployeeRole.BM;
      case 'HR':
        return EmployeeRole.HR;
      case 'Support':
        return EmployeeRole.Support;
      default:
        return EmployeeRole.Developer; // Default fallback
    }
  }

  static Icon getStatusIcon(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.approved:
        return const Icon(
          Icons.check,
          color: Colors.white,
        );
      case ApprovalStatus.rejected:
        return const Icon(
          Icons.clear_rounded,
          color: Colors.white,
        );
      default:
        return const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        );
    }
  }

  static String displayStatusFromEnum(ApprovalStatus status) {
    switch (status) {
      case ApprovalStatus.approved:
        return "Duyệt";
      case ApprovalStatus.pending:
        return "Chưa duyệt";
      case ApprovalStatus.rejected:
        return "Từ chối";
      default:
        return "Chưa duyệt";
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

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday != DateTime.saturday &&
          currentDate.weekday != DateTime.sunday) {
        totalWeekdays++;
      }
      // Chuyển sang ngày tiếp theo
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return totalWeekdays.toDouble();
  }

  static int calculateWorkingDaysInYear(int year) {
    int workingDays = 0;

    // Duyệt qua tất cả các ngày trong năm
    for (int month = 1; month <= 12; month++) {
      int daysInMonth =
          DateTime(year, month + 1, 0).day; // Lấy số ngày trong tháng

      for (int day = 1; day <= daysInMonth; day++) {
        DateTime date = DateTime(year, month, day);

        // Kiểm tra nếu không phải thứ 7 (Saturday) và Chủ Nhật (Sunday)
        if (date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday) {
          workingDays++;
        }
      }
    }

    return workingDays;
  }

  static double calculateBarWidth(BuildContext context, int numberOfBars) {
    const double maxWidth = 100.0;
    const double minWidth = 50.0;
    final double chartWidth = MediaQuery.of(context).size.width - 60.0;
    final double width = (chartWidth / numberOfBars) - 8.0;
    return width.clamp(minWidth, maxWidth);
  }

  static String displayNameOfChart(Chart chart) {
    switch (chart) {
      case Chart.aqcase:
        return "Biểu đồ tổng hợp AQ Report";
      case Chart.caseProgress:
        return "Biểu đồ tiến độ xử lý case";
      case Chart.caseWaiting:
        return "Phân bố số case theo thời gian chờ";
      case Chart.caseWaitingPieChart:
        return "Phân bố số case theo thời gian chờ";
      case Chart.devReport:
        return "Biểu đồ DEV Report";
      case Chart.supCase:
        return "Biểu đồ SUP Report";
      case Chart.supCasePieChart:
        return "Biểu đồ phân bổ tiến độ xử lý";
      case Chart.timeDistribution:
        return "Biểu đồ phân bổ thời gian";
      case Chart.workProgress:
        return "Biểu đồ tiến độ công việc";
      default:
        return "";
    }
  }

  static Widget chooseChart(Chart chart) {
    switch (chart) {
      case Chart.aqcase:
        return const AqCaseReportBarChart();
      case Chart.caseProgress:
        return const CaseProgressBarChart();
      case Chart.caseWaiting:
        return const CaseWaitingTimeBarChart();
      case Chart.caseWaitingPieChart:
        return const CaseWaitingTimePieChart();
      case Chart.devReport:
        return const DevReportBarChart();
      case Chart.supCase:
        return const SupCaseReportBarChart();
      case Chart.supCasePieChart:
        return const SupCaseReportPieChart();
      case Chart.timeDistribution:
        return const TimeDistributionBarChart();
      case Chart.workProgress:
        return const WorkProgressBarChart();
      default:
        return const Center(
          child: Text('Chon 1 bieu do'),
        );
    }
  }
}
