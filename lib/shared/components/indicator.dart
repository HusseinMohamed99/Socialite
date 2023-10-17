import 'package:flutter/material.dart';

class AdaptiveIndicator extends StatelessWidget {
  const AdaptiveIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive();
  }
}
