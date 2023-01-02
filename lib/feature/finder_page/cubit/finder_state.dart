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

class TopCardIndex extends IFinderState {
  late int index;
  TopCardIndex(this.index);
}

class FinderError extends IFinderState {
  String errorMessage;
  FinderError(this.errorMessage);
}
