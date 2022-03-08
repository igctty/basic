import 'package:redux/redux.dart';
import 'package:basic/action/actions.dart';

final counterReducer = combineReducers<int>([
  TypedReducer<int, CountUpSucceededAction>((state, action) {
    int increaseCount = action.increaseCount;
    return state + increaseCount;
  }),
]);