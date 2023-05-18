import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text/locale_text.dart';

class DraggableIngredientCircleAvatar<T extends Object> extends StatelessWidget {
  final IngredientModel model;
  final Color? color;
  final Widget? iconTopWidget;
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails)? onDragEnd;
  final Function(Velocity, Offset)? onDraggableCanceled;
  final VoidCallback? onDragCompleted;
  final Function(DragUpdateDetails)? onDragUpdate;
  final T? data;
  const DraggableIngredientCircleAvatar({Key? key, required this.model, this.color, this.iconTopWidget, this.onDragStarted, this.onDragEnd, this.onDraggableCanceled, this.onDragCompleted, this.onDragUpdate, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: data,
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
      onDraggableCanceled: onDraggableCanceled,
      onDragCompleted: onDragCompleted,
      onDragUpdate: onDragUpdate,
      feedback: Column(
        children: [
          iconTopWidget != null
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: color,
                      child: ImageSvg(
                        path: model.imagePath ?? ImagePath.like.path,
                      ),
                    ),
                    iconTopWidget!,
                  ],
                )
              : CircleAvatar(
                  radius: 32,
                  backgroundColor: color,
                  child: ImageSvg(
                    path: model.imagePath ?? ImagePath.like.path,
                  ),
                ),
          context.veryLowSizedBox,
          FittedBox(
            child: LocaleText(
              text: model.title!,
            ),
          ),
        ],
      ),
      childWhenDragging: const Center(),
      child: Column(
        children: [
          iconTopWidget != null
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: color,
                      child: ImageSvg(
                        path: model.imagePath ?? ImagePath.like.path,
                      ),
                    ),
                    iconTopWidget!,
                  ],
                )
              : CircleAvatar(
                  radius: 32,
                  backgroundColor: color,
                  child: ImageSvg(
                    path: model.imagePath ?? ImagePath.like.path,
                  ),
                ),
          context.veryLowSizedBox,
          FittedBox(
            child: LocaleText(
              fontSize: 12,
              text: model.title!,
            ),
          ),
        ],
      ),
    );
  }
}
