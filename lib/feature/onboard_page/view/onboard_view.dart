import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/enum/device_size_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/widget/button/recipe_circular_button.dart';
import '../../../product/widget_core/image_format/image_svg.dart';
import '../../../product/widget_core/pop_up_menu_button/language_popup_menu_button.dart';
import '../../../product/widget_core/text/locale_bold_text.dart';
import '../cubit/onboard_cubit.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardCubit>(
      init: (cubitRead) => cubitRead.init(),
      dispose: (cubitRead) => cubitRead.dispose(),
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: PageView.builder(
            physics: const ClampingScrollPhysics(),
            pageSnapping: true,
            controller: cubitRead.pageController,
            itemCount: cubitRead.onboardItems.length,
            onPageChanged: (value) async {
              cubitRead.changeCurrentIndex(value);
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Flexible(
                    flex: context.screenHeight < DeviceSizeEnum.inch_5.size
                        ? 18
                        : 13,
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        CustomPaint(
                          size: Size.fromHeight(context.screenHeight / 1.8),
                          painter: ShapesPainter(context),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: context.normalValue * 2.5,
                                      right: context.normalValue * 2.5),
                                  child: Padding(
                                    padding: context.paddingHighOnlyTop,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const LanguagePopupMenuButton(),
                                        TextButton(
                                          onPressed: () {
                                            NavigationService.instance
                                                .navigateToPageClear(
                                                    path: NavigationConstants
                                                        .LOGIN);
                                          },
                                          child: LocaleBoldText(
                                            text: LocaleKeys.skip,
                                            fontWeight: FontWeight.w500,
                                            locale: context.locale,
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Flexible(
                              flex: 17,
                              child: ImageSvg(
                                  path:
                                      cubitRead.onboardItems[index].imagePath),
                            ),
                            Flexible(
                              flex: 1,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        index == cubitRead.currentIndex
                                            ? Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorConstants
                                                          .instance
                                                          .russianViolet,
                                                      width: 1.5),
                                                ),
                                              )
                                            : const Center(),
                                        CircleAvatar(
                                          backgroundColor:
                                              index == cubitRead.currentIndex
                                                  ? ColorConstants
                                                      .instance.russianViolet
                                                  : ColorConstants
                                                      .instance.russianViolet
                                                      .withOpacity(0.2),
                                          radius:
                                              index == cubitRead.currentIndex
                                                  ? 4.5
                                                  : 6,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    child: Padding(
                      padding: context.paddingNormalAll,
                      child: Padding(
                        padding: context.paddingNormalEdges,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            LocaleBoldText(
                              fontWeight: FontWeight.w600,
                              text: cubitRead.onboardItems[index].title,
                              locale: context.locale,
                              textAlign: TextAlign.center,
                              fontSize: 24,
                            ),
                            Text(
                              cubitRead.onboardItems[index].explanation,
                              textAlign: TextAlign.center,
                            ),
                            index == 0
                                ? RecipeCircularButton(
                                    text: LocaleKeys.next,
                                    icon: const Icon(
                                      Icons.arrow_back_sharp,
                                      color: Colors.white,
                                    ),
                                    textDirection: ui.TextDirection.rtl,
                                    color:
                                        ColorConstants.instance.russianViolet,
                                    onPressed: () {
                                      cubitRead.changeCurrentIndex(
                                          cubitRead.currentIndex + 1);
                                    },
                                  )
                                : index == cubitRead.onboardItems.length - 1
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          RecipeCircularButton(
                                            width: context.screenWidth / 2.7,
                                            icon: Icon(
                                              Icons.arrow_back_sharp,
                                              color: ColorConstants
                                                  .instance.russianViolet,
                                            ),
                                            textDirection: ui.TextDirection.ltr,
                                            color: ColorConstants
                                                .instance.brightGraySolid2,
                                            text: LocaleKeys.back,
                                            textColor: ColorConstants
                                                .instance.russianViolet,
                                            onPressed: () {
                                              cubitRead.changeCurrentIndex(
                                                  cubitRead.currentIndex - 1);
                                            },
                                          ),
                                          RecipeCircularButton(
                                            width: context.screenWidth / 2.7,
                                            icon: const Icon(
                                              Icons.arrow_back_sharp,
                                              color: Colors.white,
                                            ),
                                            textDirection: ui.TextDirection.rtl,
                                            color: ColorConstants
                                                .instance.oriolesOrange,
                                            text: LocaleKeys.getStarted,
                                            onPressed: () {
                                              NavigationService.instance
                                                  .navigateToPage(
                                                      path: NavigationConstants
                                                          .LOGIN);
                                            },
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          RecipeCircularButton(
                                            icon: Icon(
                                              Icons.arrow_back_sharp,
                                              color: ColorConstants
                                                  .instance.russianViolet,
                                            ),
                                            textDirection: ui.TextDirection.ltr,
                                            color: ColorConstants
                                                .instance.brightGraySolid2,
                                            width: context.screenWidth / 2.7,
                                            text: LocaleKeys.back,
                                            textColor: ColorConstants
                                                .instance.russianViolet,
                                            onPressed: () {
                                              cubitRead.changeCurrentIndex(
                                                  cubitRead.currentIndex - 1);
                                            },
                                          ),
                                          RecipeCircularButton(
                                            icon: const Icon(
                                              Icons.arrow_back_sharp,
                                              color: Colors.white,
                                            ),
                                            textDirection: ui.TextDirection.rtl,
                                            width: context.screenWidth / 2.7,
                                            color: ColorConstants
                                                .instance.russianViolet,
                                            text: LocaleKeys.next,
                                            onPressed: () {
                                              cubitRead.changeCurrentIndex(
                                                  cubitRead.currentIndex + 1);
                                            },
                                          ),
                                        ],
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final BuildContext context;
  ShapesPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(
        0,
        size.height -
            (context.screenHeight < DeviceSizeEnum.inch_5.size ? 0 : 50));
    p.relativeQuadraticBezierTo(size.width / 2, 2 * 80, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(
        p,
        Paint()
          ..color = ColorConstants.instance.oriolesOrange.withOpacity(0.05));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
