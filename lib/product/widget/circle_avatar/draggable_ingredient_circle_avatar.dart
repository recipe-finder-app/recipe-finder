import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../component/text/locale_text.dart';

class DraggableIngredientCircleAvatar<T extends Object> extends StatefulWidget {
  final IngredientModel model;
  final Color? color;
  final Widget? widgetOnIcon;
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails)? onDragEnd;
  final Function(Velocity, Offset)? onDraggableCanceled;
  final VoidCallback? onDragCompleted;
  final Function(DragUpdateDetails)? onDragUpdate;
  final T? data;
  const DraggableIngredientCircleAvatar(
      {Key? key,
      required this.model,
      this.color,
      this.widgetOnIcon,
      this.onDragStarted,
      this.onDragEnd,
      this.onDraggableCanceled,
      this.onDragCompleted,
      this.onDragUpdate,
      this.data})
      : super(key: key);

  @override
  State<DraggableIngredientCircleAvatar> createState() =>
      _DraggableIngredientCircleAvatarState();
}

class _DraggableIngredientCircleAvatarState
    extends State<DraggableIngredientCircleAvatar> {
  bool onDragEnd = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.data,
      onDragStarted: () {
        setState(() {
          onDragEnd = false;
        });
      },
      onDragEnd: (DraggableDetails draggableDetails) {
        if (draggableDetails.wasAccepted) {
          setState(() {
            onDragEnd = true;
          });
          if (widget.onDragEnd != null) {
            widget.onDragEnd!(draggableDetails);
          }
        }
      },
      onDraggableCanceled: widget.onDraggableCanceled,
      onDragCompleted: widget.onDragStarted,
      onDragUpdate: widget.onDragUpdate,
      feedback: Column(
        children: [
          widget.widgetOnIcon != null
              ? Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: widget.color,
                      child: ImageSvg(
                        path: widget.model.imagePath ?? ImagePath.like.path,
                      ),
                    ),
                    widget.widgetOnIcon!,
                  ],
                )
              : CircleAvatar(
                  radius: 32,
                  backgroundColor: widget.color,
                  child: ImageSvg(
                    path: widget.model.imagePath ?? ImagePath.like.path,
                  ),
                ),
          context.veryLowSizedBox,
          FittedBox(
            child: LocaleText(
              text: widget.model.title,
            ),
          ),
        ],
      ),
      childWhenDragging: Container(),
      child: onDragEnd == true
          ? Center()
          : Column(
              children: [
                widget.widgetOnIcon != null
                    ? Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: widget.color,
                            child: ImageSvg(
                              path:
                                  widget.model.imagePath ?? ImagePath.like.path,
                            ),
                          ),
                          widget.widgetOnIcon!,
                        ],
                      )
                    : CircleAvatar(
                        radius: 32,
                        backgroundColor: widget.color,
                        child: ImageSvg(
                          path: widget.model.imagePath ?? ImagePath.like.path,
                        ),
                      ),
                context.veryLowSizedBox,
                FittedBox(
                  child: LocaleText(
                    text: widget.model.title,
                  ),
                ),
              ],
            ),
    );
  }
}

/*class DraggableIngredientCircleAvatar<T extends Object>
    extends StatelessWidget {
  final IngredientModel model;
  final Color? color;
  final Widget? widgetOnIcon;
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails)? onDragEnd;
  final Function(Velocity, Offset)? onDraggableCanceled;
  final VoidCallback? onDragCompleted;
  final Function(DragUpdateDetails)? onDragUpdate;
  final T? data;
  const DraggableIngredientCircleAvatar({
    Key? key,
    required this.model,
    this.color,
    this.widgetOnIcon,
    this.onDragStarted,
    this.onDragEnd,
    this.onDraggableCanceled,
    this.onDragCompleted,
    this.onDragUpdate,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<T>(
      data: data,
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
      onDraggableCanceled: onDraggableCanceled,
      onDragCompleted: onDragStarted,
      onDragUpdate: onDragUpdate,
      feedback: Column(
        children: [
          widgetOnIcon != null
              ? Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: color,
                      child: ImageSvg(
                        path: model.imagePath ?? ImagePath.like.path,
                      ),
                    ),
                    widgetOnIcon!,
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
              text: model.title,
            ),
          ),
        ],
      ),
      childWhenDragging: Container(),
      child: Column(
        children: [
          widgetOnIcon != null
              ? Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: color,
                      child: ImageSvg(
                        path: model.imagePath ?? ImagePath.like.path,
                      ),
                    ),
                    widgetOnIcon!,
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
              text: model.title,
            ),
          ),
        ],
      ),
    );
  }
}*/
