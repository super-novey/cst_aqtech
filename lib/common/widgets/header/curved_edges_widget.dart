import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/styles/curved_edges.dart';

class MyCurvedEdgesWidget extends StatelessWidget {
  const MyCurvedEdgesWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: MyCustomCurvedEdges(), child: child);
  }
}
