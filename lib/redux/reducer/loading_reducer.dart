import 'package:basic/redux/action/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadingAction>((state, action) => true),
  TypedReducer<bool, LoadCompleteAction>((state, action) => false),
]);