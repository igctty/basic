import 'package:flutter/material.dart';

class LoadingWidgetStreamBuilder extends StatelessWidget {
  const LoadingWidgetStreamBuilder(this.stream, {Key? key}) : super(key: key);

  final Stream<bool> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: stream,
        builder: (context, snapshot) {
          return (snapshot.data!)
              ? const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0x44000000),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : const SizedBox.shrink();
        });
  }
}