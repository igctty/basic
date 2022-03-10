import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:basic/scopedmodel/loading_model.dart';

class LoadingWidgetScopedModel extends StatelessWidget {
  const LoadingWidgetScopedModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, child, LoadingModel model) {
        return (model.value)
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