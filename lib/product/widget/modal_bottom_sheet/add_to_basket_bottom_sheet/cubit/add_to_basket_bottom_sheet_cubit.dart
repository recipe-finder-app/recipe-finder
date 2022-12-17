/*class LikesCubit extends Cubit<ILikesState> implements IBaseViewModel {
  late List<IngredientModel> myFrizeItems;
  late List<LikeRecipeModel> missingItems;
  LikesCubit() : super(LikesInit());
  @override
  void init() {
    likeRecipeItems = [
      LikeRecipeModel(
        missingItems: [
          IngredientModel(
              title: 'egg', imagePath: ImagePath.egg.path, quantity: 5),
          IngredientModel(
              title: 'milk', imagePath: ImagePath.milk.path, quantity: 6),
          IngredientModel(
              title: 'bread', imagePath: ImagePath.bread.path, quantity: 3),
          IngredientModel(
              title: 'salad', imagePath: ImagePath.salad.path, quantity: 2),
          IngredientModel(
              title: 'chicken', imagePath: ImagePath.chicken.path, quantity: 4),
        ],
      ),
    ];

    myFrizeItems = [
      IngredientModel(
          title: 'milk', imagePath: ImagePath.milk.path, quantity: 6),
      IngredientModel(
          title: 'bread', imagePath: ImagePath.bread.path, quantity: 3),
      IngredientModel(
          title: 'salad', imagePath: ImagePath.salad.path, quantity: 2),
      IngredientModel(title: 'egg', imagePath: ImagePath.egg.path, quantity: 3),
      IngredientModel(
          title: 'potato', imagePath: ImagePath.potato.path, quantity: 2),
      IngredientModel(
          title: 'chicken', imagePath: ImagePath.chicken.path, quantity: 2),
    ];
  }

  void addItemToMissingList(int cardIndex, IngredientModel model) {
    List<IngredientModel> value = likeRecipeItems[cardIndex]
        .missingItems!
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isEmpty) {
      likeRecipeItems[cardIndex].missingItems!.add(model);
      emit(MissingItemListLoad(
          likeRecipeItems[cardIndex].missingItems!.toSet().toList()!));
    }
  }

  void removeMissingItem(int cardIndex, IngredientModel model) {
    List<IngredientModel> value = likeRecipeItems[cardIndex]
        .missingItems!
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isNotEmpty) {
      likeRecipeItems[cardIndex].missingItems!.remove(model);

      emit(MissingItemListLoad(
          likeRecipeItems[cardIndex].missingItems!.toSet().toList()!));
    }
  }

  void addItemToMyFrizeList(IngredientModel model) {
    List<IngredientModel> value = myFrizeItems
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isEmpty) {
      myFrizeItems.add(model);

      emit(MyFrizeListLoad(myFrizeItems.toSet().toList()));
    }
  }

  void removeMyFrizeItem(IngredientModel model) {
    List<IngredientModel> value = myFrizeItems
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isNotEmpty) {
      myFrizeItems.remove(model);

      emit(MyFrizeListLoad(myFrizeItems.toSet().toList()!));
    }
  }

  void missingItemLoad(int cardIndex) {
    emit(MissingItemListLoad(
        likeRecipeItems[cardIndex].missingItems!.toSet().toList()));
  }

  void deleteItemFromLikedRecipeList(LikeRecipeModel model) {
    likeRecipeItems.remove(model);
    emit(LikesRecipeItemListLoad(likeRecipeItems.toSet().toList()));
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    likeRecipeItems = [];
  }
}
*/
