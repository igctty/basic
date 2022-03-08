import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:basic/state/app_state.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.isLoading,
      builder: (context, isLoading) {
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