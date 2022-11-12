abstract class ILikesState {
  ILikesState();
}

class LikesInit extends ILikesState {
  LikesInit();
}

class OnLikesLoading extends ILikesState {
  late bool isLoading;
  OnLikesLoading(isLoading);
}

class LikesError extends ILikesState {
  String errorMessage;
  LikesError(this.errorMessage);
}
