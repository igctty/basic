import 'package:basic/redux/state/app_state.dart';

import 'counter_reducer.dart';
import 'loading_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    counter: counterReducer(state.counter, action),
  );
}