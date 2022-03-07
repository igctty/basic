import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  final bool isLoading;
  const LoadingWidget(this.isLoading);

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