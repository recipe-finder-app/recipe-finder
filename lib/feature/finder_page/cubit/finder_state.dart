import 'package:swipable_stack/swipable_stack.dart';

abstract class IFinderState {
  IFinderState();
}

class FinderInit extends IFinderState {
  FinderInit();
}

class OnFinderLoading extends IFinderState {
  late bool isLoading;
  OnFinderLoading(isLoading);
}

class FinderError extends IFinderState {
  String errorMessage;
  FinderError(this.errorMessage);
}


