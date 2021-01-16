import 'actions.dart';
import 'store.dart';

AppState reducers(AppState prevState, dynamic action) {
  switch (action) {
    case FetchVideosSucceded:
      return prevState.copyWith();
      break;
    case FetchVideosFailed:
      return prevState.copyWith();
      break;
    default:
      return prevState.copyWith();
      break;
  }
}
