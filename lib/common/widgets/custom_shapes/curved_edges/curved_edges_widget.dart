import 'package:flutter/material.dart';

import 'curved_edges.dart';

class KCurvedEdgeWidget extends StatelessWidget {
  const KCurvedEdgeWidget({
    super.key, this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {


    return ClipPath(
      clipper: KCustomCurvedEdges(),
      child: child,
    );
  }
}