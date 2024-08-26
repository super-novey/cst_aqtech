import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_details/employee_detail.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;

  const EmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          {Get.to(() => EmployeeDetailScreen(selectedEmployee: employee))},
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 24,
                    child: employee.avatar.isEmpty ||
                            employee.avatar == 'avatar content'
                        ? const Text(
                            'A',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.fullName,
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems / 2),
                        Text(
                          employee.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (employee.isLeader)
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 239, 89, 52),
                      size: MySizes.iconLg,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ngày bắt đầu: ${MyFormatter.formatDateTime(employee.startDate)}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: HeplerFunction.getRoleColor(employee.role),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      employee.role.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
