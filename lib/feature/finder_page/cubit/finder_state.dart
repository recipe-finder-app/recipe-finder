abstract class IFinderState {
  IFinderState();
}

class FinderInit extends IFinderState {
  FinderInit();
}

class OnFinderLoading extends IFinderState {
  late bool isLoading;
  OnFinderLoading(this.isLoading);
}

class RecipeListItemCountCounter extends IFinderState {
  late int count;
  RecipeListItemCountCounter(this.count);
}

class FinderError extends IFinderState {
  String errorMessage;
  FinderError(this.errorMessage);
}

class VideoPlaybackState extends IFinderState {
  late Future<void> controller;
  VideoPlaybackState(this.controller);
}
