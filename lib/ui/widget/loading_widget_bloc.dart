import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic/bloc/loading_bloc.dart';

class LoadingWidgetBLoC extends StatelessWidget {
  const LoadingWidgetBLoC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<LoadingBloc>(context);
    return StreamBuilder<bool>(
        initialData: false,
        stream: bloc.value,
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