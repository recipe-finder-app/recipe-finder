import '../../likes_page/model/like_recipe_model.dart';

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

class CurrentSwipedCard extends IFinderState {
  late LikeRecipeModel currentSwipedCardModel;
  CurrentSwipedCard(this.currentSwipedCardModel);
}

class FinderError extends IFinderState {
  String errorMessage;
  FinderError(this.errorMessage);
}

class VideoPlaybackState extends IFinderState {
  late Future<void> controller;
  VideoPlaybackState(this.controller);
}
