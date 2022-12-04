import 'package:flutter/material.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_cubit.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/search/auto_complete_widget.dart';

class MaterialSearchView extends StatefulWidget {
  MaterialSearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<MaterialSearchView> createState() => _MaterialSearchViewState();
}

class _MaterialSearchViewState extends State<MaterialSearchView> {
  bool _click = true;
  @override
  Widget build(BuildContext context) {
    return BaseView<MaterialSearchCubit>(
        init: (cubitRead) {
          cubitRead.init();
          cubitRead.essentialList();
          cubitRead.vegatablesList();
        },
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: context.floatinValueWidth,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      _click = !_click;
                    });
                  },
                  backgroundColor: _click
                      ? ColorConstants.instance.roboticgods.withOpacity(1)
                      : ColorConstants.instance.oriolesOrange,
                  shape: RoundedRectangleBorder(
                      borderRadius: context.radiusAllCircularMin),
                  label: LocaleText(
                    text: LocaleKeys.findMyRecipe,
                    style: TextStyle(color: ColorConstants.instance.white),
                  ),
                ),
              ),
              body: SafeArea(
                child: Padding(
                    padding: context.paddingNormalEdges,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        context.mediumSizedBox,
                        _textRow(context),
                        context.mediumSizedBox,
                        Column(children: [
                          AutoCompleteWidget(),
                          context.normalSizedBox,
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: LocaleText(
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  text: LocaleKeys.essentials,
                                ),
                              ),
                              context.normalSizedBox,
                              SizedBox(
                                height: context.normalhighValue,
                                width: context.veryValueWidth,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cubitRead.essentials.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: context.paddingRight,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 32,
                                              backgroundColor: cubitRead
                                                  .essentials[index].color,
                                              child: ImageSvg(
                                                  path: cubitRead
                                                          .essentials[index]
                                                          .image ??
                                                      ''),
                                            ),
                                            context.lowSizedBox,
                                            LocaleText(
                                              text: cubitRead.essentials[index]
                                                      .title ??
                                                  '',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstants
                                                      .instance.roboticgods),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              context.normalSizedBox,
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: LocaleText(
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  text: LocaleKeys.vegatables,
                                ),
                              ),
                              context.normalSizedBox,
                              SizedBox(
                                height: context.screenHeight / 1.35,
                                child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cubitRead.vegatables.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 0.70,
                                            crossAxisSpacing: 25,
                                            mainAxisSpacing: 15),
                                    itemBuilder: (BuildContext context, index) {
                                      return Column(
                                        children: [
                                          CircleAvatar(
                                              radius: 32,
                                              backgroundColor: cubitRead
                                                  .vegatables[index].color,
                                              child: ImageSvg(
                                                path: cubitRead
                                                        .vegatables[index]
                                                        .image ??
                                                    '',
                                              )),
                                          context.lowSizedBox,
                                          SizedBox(
                                            width: context.veryHighValue,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: LocaleText(
                                                text: cubitRead
                                                        .vegatables[index]
                                                        .title ??
                                                    '',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorConstants
                                                        .instance.roboticgods),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              context.normalSizedBox,
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: LocaleText(
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal),
                                  text: LocaleKeys.fruits,
                                ),
                              ),
                              context.normalSizedBox,
                              SizedBox(
                                height: context.screenHeight / 1.30,
                                child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cubitRead.vegatables.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 0.70,
                                            crossAxisSpacing: 25,
                                            mainAxisSpacing: 15),
                                    itemBuilder: (BuildContext context, index) {
                                      return Column(
                                        children: [
                                          CircleAvatar(
                                              radius: 32,
                                              backgroundColor: cubitRead
                                                  .vegatables[index].color,
                                              child: ImageSvg(
                                                path: cubitRead
                                                        .vegatables[index]
                                                        .image ??
                                                    '',
                                              )),
                                          context.lowSizedBox,
                                          SizedBox(
                                            width: context.veryHighValue,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: LocaleText(
                                                text: cubitRead
                                                        .vegatables[index]
                                                        .title ??
                                                    '',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorConstants
                                                        .instance.roboticgods),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                          //
                        ]),
                      ]),
                    )),
              ),
            ));
  }

  Widget _textRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: LocaleText(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: ColorConstants.instance.blackbox,
              ),
              text: LocaleKeys.selectIngredients,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(path: NavigationConstants.NAV_CONTROLLER);
          },
          child: LocaleText(
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: ColorConstants.instance.shadowplanet,
                decoration: TextDecoration.underline,
                decorationColor: ColorConstants.instance.shadowplanet,
                decorationThickness: 2,
              ),
              text: LocaleKeys.later),
        ),
      ],
    );
  }
}
