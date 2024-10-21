import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/format_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/update_over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_detail/widgets/over_time_datepicker.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_detail/widgets/over_time_text_filed.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:searchfield/searchfield.dart';

class OverTimeDetailScreen extends StatelessWidget {
  OverTimeDetailScreen({super.key, required this.selectedOverTime});
  final OverTime selectedOverTime;
  final updateOverTimeController = UpdateOverTimeController.instance;
  final employeeController = Get.put(EmployeeController());

  final _formKey = GlobalKey<FormState>(); // Add GlobalKey for the form
  final _searchFieldController = TextEditingController();

  void fetchOverTimeDetails() {
    updateOverTimeController.dateController.text =
        MyFormatter.formatDate(selectedOverTime.date.toString());
    updateOverTimeController.noteController.text = selectedOverTime.note;
    updateOverTimeController.timeController.text =
        selectedOverTime.time.toString();
    String formattedTime =
        FormatTimeController().formatTimeController(selectedOverTime.time);
    updateOverTimeController.timeController.text = formattedTime;

    String selectedEmployeeId = selectedOverTime.memberId.toString();
    final allEmployeeIds =
        employeeController.allEmployees.map((e) => e.id.toString()).toSet();
    if (allEmployeeIds.contains(selectedEmployeeId)) {
      updateOverTimeController.selectedEmployee.value = selectedEmployeeId;
    } else {
      updateOverTimeController.selectedEmployee.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchOverTimeDetails();
    _searchFieldController.text =
        updateOverTimeController.selectedEmployee.value != null
            ? employeeController
                .getEmployeeNameById(
                    int.parse(updateOverTimeController.selectedEmployee.value!))
                .toString()
            : "";
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
            updateOverTimeController.isEditting.value = false;
            Get.back();
          },
        ),
        actions: [
          //if (AuthenticationController.instance.currentUser.isLeader)
          Obx(
            () => IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (updateOverTimeController.isEditting.value) {
                    if (updateOverTimeController.isAdd.value) {
                      updateOverTimeController.save(selectedOverTime, true);
                    } else {
                      updateOverTimeController.save(selectedOverTime, false);
                    }
                  } else {
                    updateOverTimeController.toggleEditting();
                  }
                }
              },
              icon: Icon(
                updateOverTimeController.isEditting.value
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Họ tên",
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Form(
                    key: _formKey,
                    child: SearchField(
                      controller: _searchFieldController,
                      suggestions: employeeController.allEmployees
                          .where((Employee employee) {
                        return AuthenticationController
                                .instance.currentUser.isLeader ||
                            employee.id ==
                                AuthenticationController
                                    .instance.currentUser.id;
                      }).map((Employee employee) {
                        return SearchFieldListItem(employee.fullName,
                            item: employee.id);
                      }).toList(),
                      validator: (x) {
                        // Check if the input exists in the list of employee full names
                        if (x == null ||
                            !employeeController.allEmployees
                                .where((Employee employee) {
                                  return AuthenticationController
                                          .instance.currentUser.isLeader ||
                                      employee.id ==
                                          AuthenticationController
                                              .instance.currentUser.id;
                                })
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
                      onSuggestionTap: updateOverTimeController.isEditting.value
                          ? (SearchFieldListItem<int> item) {
                              int selectedEmployeeId = item.item!;
                              print(
                                  "Selected Employee ID: $selectedEmployeeId");
                              updateOverTimeController.selectedEmployee.value =
                                  selectedEmployeeId.toString();
                            }
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: MySizes.sm,
              ),
              const SizedBox(
                height: MySizes.sm,
              ),
              OverTimeDatePicker(
                controller: updateOverTimeController.dateController,
                label: "Ngày",
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),
              OverTimeTextFiled(
                textController: updateOverTimeController.timeController,
                label: 'Số giờ',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
              OverTimeTextFiled(
                textController: updateOverTimeController.noteController,
                label: 'Ghi chú',
                maxLines: 15,
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
