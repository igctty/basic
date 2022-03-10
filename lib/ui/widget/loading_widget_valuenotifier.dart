import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic/scopedmodel/valuenotifier/loading_value.dart';

class LoadingWidgetValuenotifier extends StatelessWidget {
  const LoadingWidgetValuenotifier(this.value,{Key? key}) : super(key: key);

  final LoadingValue value;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: value.isLoading,
      builder: (_context, isLoading, _child) {
        return (isLoading)
            ? const DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0x44000000),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
            : const SizedBox.shrink();
      },
    );
  }
}

class LoadingWidgetScProvider extends StatelessWidget {
  const LoadingWidgetScProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<LoadingValueScoped>(context);
    return (logic.value)
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