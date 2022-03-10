import 'package:flutter/material.dart';

class LoadingWidgetSetState extends StatelessWidget {
  const LoadingWidgetSetState({Key? key ,required this.isLoading}) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0x44000000),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    )
        : const SizedBox.shrink();
  }
}