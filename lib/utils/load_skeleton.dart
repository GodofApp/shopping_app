

import 'package:flutter/cupertino.dart';
import 'package:shopping_app/utils/skeleton.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeleton(height: 200, weight: 500)
      ],
    );
  }
}
