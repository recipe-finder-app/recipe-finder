/*class AddToBasketBottomSheet{
  Future<void> show<T extends Cubit>(
      BuildContext context, LikesCubit cubitRead, int cardIndex) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.short,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Flexible(
              flex: 1, child: LocaleBoldText(text: LocaleKeys.missingItem)),
          if (cubitRead.likeRecipeItems[cardIndex].missingItems == null)
            const Center()
          else
            BlocSelector<LikesCubit, ILikesState, List<IngredientModel>>(
              selector: (state) {
                if (state is MissingItemListLoad) {
                  return state.missingItemList;
                } else {
                  return cubitRead.likeRecipeItems[cardIndex].missingItems ??
                      [];
                }
              },
              builder: (BuildContext context, state) {
                return Flexible(
                  flex: 4,
                  child: DragTarget<IngredientModel>(onAccept: (data) {
                    cubitRead.addItemToMissingList(cardIndex, data);
                    cubitRead.removeMyFrizeItem(data);
                  }, builder: (BuildContext context,
                      List<Object?> candidateData, List<dynamic> rejectedData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.length,
                        itemBuilder:
                            (BuildContext context, int missingItemIndex) {
                          return Padding(
                            padding: EdgeInsets.only(right: context.lowValue),
                            child: DraggableIngredientCircleAvatar<
                                IngredientModel>(
                              data: state[missingItemIndex],
                              iconBottomWidget: BoldText(
                                text:
                                state[missingItemIndex].quantity.toString(),
                                textColor: Colors.white,
                              ),
                              color: ColorConstants.instance.oriolesOrange
                                  .withOpacity(0.4),
                              model: state[missingItemIndex],
                            ),
                          );
                        });
                  }),
                );
              },
            ),
          const Flexible(
              flex: 1, child: LocaleBoldText(text: LocaleKeys.yourFrize)),
          BlocSelector<LikesCubit, ILikesState, List<IngredientModel>>(
              selector: (state) {
                if (state is MyFrizeListLoad) {
                  return state.myFrizeList;
                } else {
                  return cubitRead.myFrizeItems ?? [];
                }
              }, builder: (BuildContext context, state) {
            return Flexible(
              flex: 4,
              child: cubitRead.myFrizeItems == null
                  ? const Center()
                  : DragTarget<IngredientModel>(
                onAccept: (data) {
                  cubitRead.addItemToMyFrizeList(data);
                  cubitRead.removeMissingItem(cardIndex, data);
                },
                builder: (BuildContext context,
                    List<Object?> candidateData,
                    List<dynamic> rejectedData) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.length,
                      itemBuilder:
                          (BuildContext context, int myFrizeItemIndex) {
                        return Padding(
                          padding:
                          EdgeInsets.only(right: context.lowValue),
                          child: DraggableIngredientCircleAvatar<
                              IngredientModel>(
                            data: state[myFrizeItemIndex],
                            iconBottomWidget: BoldText(
                              text: state[myFrizeItemIndex]
                                  .quantity
                                  .toString(),
                              textColor: Colors.white,
                            ),
                            color:
                            ColorConstants.instance.brightGraySolid2,
                            model: state[myFrizeItemIndex],
                          ),
                        );
                      });
                },
              ),
            );
          }),
          RecipeCircularButton(
              color: ColorConstants.instance.oriolesOrange,
              text: LocaleKeys.confirm),
        ],
      ),
    );
  }
}
*/
