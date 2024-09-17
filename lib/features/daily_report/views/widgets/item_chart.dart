import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class ItemChart extends StatefulWidget {
  const ItemChart({
    super.key,
    required this.color,
    required this.label,
    this.onClick,
  });
  final Color color;
  final String label;
  final VoidCallback? onClick;

  @override
  State<ItemChart> createState() => _ItemChartState();
}

class _ItemChartState extends State<ItemChart> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClick = !isClick;
        });
        if (widget.onClick != null) {
          widget.onClick!();
        }
      },
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              color: widget.color,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(widget.label,
              style: TextStyle(
                fontSize: 16, 
                color: isClick ? MyColors.secondaryTextColor : Colors.black))
        ],
      ),
    );
  }
}
