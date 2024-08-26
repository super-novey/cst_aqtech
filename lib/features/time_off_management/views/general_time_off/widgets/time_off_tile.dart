import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class TimeOffTile extends StatelessWidget {
  const TimeOffTile({super.key, required this.timeOff});
  final GeneralTimeOff timeOff;

  @override
  Widget build(BuildContext context) {
    var boxShadow = const BoxShadow(
        blurRadius: 2,
        spreadRadius: 2,
        color: Color.fromARGB(255, 229, 225, 225));
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [boxShadow]),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeOff.reason,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text.rich(TextSpan(
                text: "Ghi chú: ",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey),
                children: [
                  TextSpan(
                      text: timeOff.note,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey))
                ])),
            Text.rich(TextSpan(
                text: "Số ngày nghỉ: ",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey),
                children: [
                  TextSpan(
                      text: timeOff.sumDay.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey))
                ])),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    Text(
                      MyFormatter.formatDate(timeOff.dateFrom.toString()),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_right_alt_outlined),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    Text(
                      MyFormatter.formatDate(timeOff.dateTo.toString()),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
