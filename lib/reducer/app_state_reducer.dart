import 'package:basic/state/app_state.dart';
import 'package:basic/reducer/counter_reducer.dart';
import 'package:basic/reducer/loading_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    counter: counterReducer(state.counter, action),
  );
}

