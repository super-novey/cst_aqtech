import 'package:hrm_aqtech/features/daily_report/models/aq_case_report_model.dart';
import 'package:hrm_aqtech/features/daily_report/models/case_waiting_time_model.dart';
import 'package:hrm_aqtech/features/daily_report/models/coder_case_report_model.dart';
import 'package:hrm_aqtech/features/daily_report/models/sup_case_report_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class DailyReportRepository {
  Future<List<CaseWaitingTime>> fetchCaseWaitingTimeData() async {
    try {
      final response = await HttpHelper.post(
          "ThongKe/w-PhanBoSoCaseTheoThoiGianChoCoder", {});
      List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((item) => CaseWaitingTime.fromJson(item)).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<AqCaseReport>> fetchAQCaseReport(String selectedDate) async {
    try {
      final request = {
        "data": selectedDate,
      };
      final response = await HttpHelper.post("ThongKe/w-AqCaseReport", request);
      List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((item) => AqCaseReport.fromJson(item)).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<SupCaseReport>> fetchSupCaseReport(String selectedDate) async {
    try {
      final request = {
        "data": selectedDate, 
      };
      final response =
          await HttpHelper.post("ThongKe/w-supCaseReport", request);
      List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((item) => SupCaseReport.fromJson(item)).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<CoderCaseReport>> fetchCoderCaseReport(String selectedDate) async {
  try {
    final request = {
      "data": selectedDate, 
    };
    final response =
        await HttpHelper.post("ThongKe/w-coderCaseReport", request);
    List<dynamic> data = response['data'] as List<dynamic>;
    return data.map((item) => CoderCaseReport.fromJson(item)).toList();
  } on Exception catch (_) {
    rethrow;
  }
}

}
