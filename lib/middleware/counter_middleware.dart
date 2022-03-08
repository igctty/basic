import 'package:redux/redux.dart';

import 'package:basic/action/actions.dart';
import 'package:basic/repository/counter_repository.dart';
import 'package:basic/state/app_state.dart';

List<Middleware<AppState>> counterMiddleware(
    CountRepository repository,
    ) {
  return [
    TypedMiddleware<AppState, CountUpAction>(_fetch(repository)),
  ];
}

void Function(
    Store<AppState> store,
    CountUpAction action,
    NextDispatcher next,
    ) _fetch(
    CountRepository repository,
    ) {
  return (store, action, next) {
    next(action);
    next(LoadingAction());
    repository.fetch().then((increaseCount) {
      store.dispatch(CountUpSucceededAction(increaseCount));
    }).catchError((error) {
      print(error);
    }).whenComplete(() {
      next(LoadCompleteAction());
    });
  };
}