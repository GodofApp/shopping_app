

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {

  final double height,weight;

  const Skeleton({super.key, required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: weight,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
    );
  }
}
