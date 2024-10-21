import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/absence_quota_card.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/editable_text_field_with_checkbox.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/leave_day_date_picker.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/editable_text_field.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/helper_function.dart';
import 'package:searchfield/searchfield.dart';

class LeaveDayDetailScreen extends StatelessWidget {
  LeaveDayDetailScreen({super.key, required this.selectedLeaveDay});
  final LeaveDay selectedLeaveDay;
  final updateLeaveDayController = UpdateLeaveDayController.instance;
  final employeeController = Get.put(EmployeeController());
  final LeaveDayController controller = Get.find();

  final TextEditingController searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Add GlobalKey for the form

  void fetchLeaveDayDetails() {
    updateLeaveDayController.dateFromController.text =
        MyFormatter.formatDate(selectedLeaveDay.dateFrom.toString());
    updateLeaveDayController.dateToController.text =
        MyFormatter.formatDate(selectedLeaveDay.dateTo.toString());

    updateLeaveDayController.reasonController.text = selectedLeaveDay.reason;
    updateLeaveDayController.noteController.text = selectedLeaveDay.note;

    String formattedSumDay =
        FormatSumDayController().formatLeaveDay(selectedLeaveDay.sumDay);
    updateLeaveDayController.sumDayController.text = formattedSumDay;
    updateLeaveDayController.numberOfDayWhole.text =
        selectedLeaveDay.numberOfDayWhole.toString();
    updateLeaveDayController.numberOfDayHalf.text =
        selectedLeaveDay.numberOfDayHalf.toString();
    updateLeaveDayController.sumDayController.text = formattedSumDay;
    updateLeaveDayController.isAnnual.value = selectedLeaveDay.isAnnual;
    updateLeaveDayController.totalIsAnnual.text =
        selectedLeaveDay.totalIsAnnual.toString();
    updateLeaveDayController.isWithoutPay.value = selectedLeaveDay.isWithoutPay;
    updateLeaveDayController.totalIsWithoutPay.text =
        selectedLeaveDay.totalIsWithoutPay.toString();

    String selectedEmployeeId = selectedLeaveDay.memberId.toString();
    final allEmployeeIds =
        employeeController.allEmployees.map((e) => e.id.toString()).toSet();
    if (allEmployeeIds.contains(selectedEmployeeId)) {
      updateLeaveDayController.selectedEmployee.value = selectedEmployeeId;
    } else {
      updateLeaveDayController.selectedEmployee.value = null;
    }
    updateLeaveDayController.selectedApprovalStatus.value =
        selectedLeaveDay.approvalStatus;

    var year = DateTime.now().year;
    int memberId = 0;
    if (UpdateLeaveDayController.instance.selectedEmployee.value != null) {
      memberId =
          int.parse(UpdateLeaveDayController.instance.selectedEmployee.value!);
      controller.getAbsenceQuota(year, memberId);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchLeaveDayDetails();

    final _employeeNames =
        employeeController.allEmployees.where((Employee employee) {
      return AuthenticationController.instance.currentUser.isLeader ||
          employee.id == AuthenticationController.instance.currentUser.id;
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            updateLeaveDayController.isEditting.value = false;
            updateLeaveDayController.searchQuery.value = '';
            updateLeaveDayController.selectedEmployee.value = '';
            Get.back();
          },
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (updateLeaveDayController.isEditting.value) {
                    if (updateLeaveDayController.isAdd.value) {
                      updateLeaveDayController.save(selectedLeaveDay, true);
                    } else {
                      updateLeaveDayController.save(selectedLeaveDay, false);
                    }
                  } else {
                    updateLeaveDayController.toggleEditting();
                  }
                }
              },
              icon: Icon(
                updateLeaveDayController.isEditting.value
                    ? Icons.save
                    : Icons.edit,
                size: 24,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AuthenticationController.instance.currentUser.isLeader)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Trạng thái",
                        style: Theme.of(context).textTheme.bodySmall!),
                    const SizedBox(height: 2),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MySizes.borderRadiusMd),
                        border:
                            Border.all(color: MyColors.accentColor, width: 1),
                      ),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<ApprovalStatus>(
                            value: updateLeaveDayController
                                .selectedApprovalStatus.value,
                            dropdownColor: MyColors.iconColor,
                            onChanged: updateLeaveDayController.isEditting.value
                                ? (ApprovalStatus? status) {
                                    if (status != null) {
                                      updateLeaveDayController
                                          .selectedApprovalStatus
                                          .value = status;
                                    }
                                  }
                                : null,
                            items: ApprovalStatus.values
                                .map((ApprovalStatus status) {
                              return DropdownMenuItem<ApprovalStatus>(
                                value: status,
                                child: Padding(
                                  padding: const EdgeInsets.all(MySizes.sm),
                                  child: Text(
                                    HeplerFunction.displayStatusFromEnum(
                                        status),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: MySizes.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Họ tên", style: Theme.of(context).textTheme.bodySmall!),
                  const SizedBox(height: 2),
                  Form(
                    key: _formKey,
                    child: SearchField(
                      suggestions: _employeeNames
                          .map((Employee e) =>
                              SearchFieldListItem(e.fullName, item: e.id))
                          .toList(),
                      validator: (x) {
                        // Check if the input exists in the list of employee full names
                        if (x == null ||
                            !_employeeNames
                                .map((e) => e.fullName)
                                .contains(x)) {
                          return 'Tên nhân viên không tồn tại';
                        }
                        return null;
                      },
                      suggestionState: Suggestion.expand,
                      textInputAction: TextInputAction.next,
                      hint: 'Nhập tên nhân viên',
                      searchInputDecoration: SearchInputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      onSuggestionTap: (SearchFieldListItem<int> item) {
                        int selectedEmployeeId = item.item!;
                        print("Selected Employee ID: $selectedEmployeeId");
                        updateLeaveDayController.selectedEmployee.value =
                            selectedEmployeeId.toString();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              DateTimePicker(
                controller: updateLeaveDayController.dateFromController,
                label: "Ngày bắt đầu nghỉ",
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              DateTimePicker(
                controller: updateLeaveDayController.dateToController,
                label: "Ngày kết thúc",
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              EditableTextField(
                textController: updateLeaveDayController.sumDayController,
                label: 'Tổng số ngày nghỉ',
                isNumberInput: true,
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextField(
                textController: updateLeaveDayController.numberOfDayWhole,
                label: 'Số lượng ngày nghỉ (trọn ngày)',
                isNumberInput: true,
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextField(
                textController: updateLeaveDayController.numberOfDayHalf,
                label: 'Số lượng ngày nghỉ (nửa ngày)',
                isNumberInput: true,
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextFieldWithCheckbox(
                textController: updateLeaveDayController.totalIsAnnual,
                label: 'Tính vào nghỉ phép năm',
                isNumberInput: true,
                field: 0,
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextFieldWithCheckbox(
                textController: updateLeaveDayController.totalIsWithoutPay,
                label: 'Tính vào nghỉ không lương',
                isNumberInput: true,
                field: 1,
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              // Obx(() {
              //   if (UpdateLeaveDayController.instance.selectedEmployee.value !=
              //       null) {
              //     return const AbsenceQuotaCard();
              //   } else {
              //     return Container();
              //   }
              // }),
              const AbsenceQuotaCard(),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextField(
                textController: updateLeaveDayController.reasonController,
                label: 'Lý do nghỉ',
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextField(
                textController: updateLeaveDayController.noteController,
                label: 'Ghi chú',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
