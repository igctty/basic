import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:basic/redux/middleware/counter_middleware.dart';
import 'package:basic/repository/count_repository.dart';

import '../redux/action/actions.dart';
import '../redux/reducer/app_state_reducer.dart';
import '../redux/state/app_state.dart';
import 'widget/loading_widget_redux.dart';

@immutable
class TopPageRedux extends StatelessWidget {
  TopPageRedux(this._repository, {Key? key})
      : store = Store<AppState>(
    appStateReducer,
    initialState: const AppState(),
    middleware: counterMiddleware(_repository),
  ), super(key: key);

  final CountRepository _repository;
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Redux Demo'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _TopContent(),
                _MiddleContent(),
                _BottomContent(),
              ],
            ),
          ),
          const LoadingWidgetRedux(),
        ],
      ),
    );
  }
}

class _TopContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called RX: _TopContent#build()");
    return Center(
      child: StoreConnector<AppState, int>(
        converter: (store) => store.state.counter,
        builder: (context, counter) {
          return Text(
            '$counter',
            style: Theme.of(context).textTheme.displayMedium,
          );
        },
      ),
    );
  }
}

class _MiddleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called RX: _MiddleContent#build()");
    return const Text('I am a Widget that will not be rebuilt.');
  }
}

class _BottomContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called RX: _BottomContent#build()");
    return ElevatedButton(
      onPressed: () {
        var store = StoreProvider.of<AppState>(context);
        store.dispatch(CountUpAction(store.state.counter));
      },
      child: const Icon(Icons.add),
    );
  }
}