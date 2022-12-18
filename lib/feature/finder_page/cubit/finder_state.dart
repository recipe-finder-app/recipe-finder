import 'package:recipe_finder/product/model/ingradient_model.dart';
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

class VideoPlaybackState extends IFinderState {
  late Future<void> controller;
  VideoPlaybackState(this.controller);
}
