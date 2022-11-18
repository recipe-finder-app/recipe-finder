import 'package:flutter/material.dart';

import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_cubit.dart';
import 'package:recipe_finder/feature/material_search_page/model/model.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/app_bar/text_app_bar.dart';
import 'package:recipe_finder/product/widget/search/search_widget.dart';

class MaterialSearchView extends StatelessWidget {
  MaterialSearchView({
    Key? key,
  }) : super(key: key);

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
              floatingActionButton: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 320,
                child: FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: ColorConstants.instance.roboticgods,
                  label: Text(
                    'Find My Recipe',
                    style: TextStyle(color: ColorConstants.instance.white),
                  ),
                ),
              ),
              body: SafeArea(
                child: Padding(
                    padding: context.paddingNormalEdges,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        TextAppBar(
                          title: 'Select your have ingredients',
                          onPressed: () {
                            /**
                 NavigationService.instance
                      .navigateToPage(path: NavigationConstants.NAV_CONTROLLER);
                  */
                          },
                          widget: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: LocaleText(
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.instance.shadowplanet,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        ColorConstants.instance.shadowplanet,
                                    decorationThickness: 2,
                                  ),
                                  text: LocaleKeys.later)),
                          color: Colors.transparent,
                        ),
                        context.mediumSizedBox,
                        Container(
                          width: context.veryValueWidth,
                          decoration: BoxDecoration(
                            color: ColorConstants.instance.white,
                            border: Border.all(
                                color: ColorConstants.instance.roboticgods
                                    .withOpacity(0.9),
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Autocomplete<SerachModel>(
                            optionsBuilder: (textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<SerachModel>.empty();
                              }
                              return searchList.where(
                                (element) => element.title!
                                    .contains(textEditingValue.text),
                              );
                            },
                            onSelected: (value) {},
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<SerachModel> onSelected,
                                Iterable<SerachModel> options) {
                              final list = options.toList();
                              String firsType = list.first.type ?? '';

                              for (var i = 1; i < list.length; i++) {
                                !firsType.contains(list[i].type!)
                                    ? firsType = '$firsType + ${list[i].type!}'
                                    : '';
                              }
                              return Scaffold(
                                body: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      context.normalSizedBox,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: LocaleText(
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                          text: firsType,
                                        ),
                                      ),
                                      Expanded(
                                        child: GridView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: list.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    childAspectRatio: 0.70,
                                                    crossAxisSpacing: 25,
                                                    mainAxisSpacing: 15),
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return Column(
                                                //crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 32,
                                                    child: list[index].image,
                                                  ),
                                                  context.lowSizedBox,
                                                  SizedBox(
                                                    width:
                                                        context.veryHighValue,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: LocaleText(
                                                        text:
                                                            list[index].title ??
                                                                '',
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: ColorConstants
                                                                .instance
                                                                .roboticgods),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      )
                                    ]),
                              );
                            },
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController
                                    fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              return TextFormField(
                                controller: fieldTextEditingController,
                                focusNode: fieldFocusNode,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: ImageSvg(
                                      path: ImagePath.searchh.path,
                                      color:
                                          ColorConstants.instance.shadowplanet),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color:
                                          ColorConstants.instance.roboticgods,
                                      fontWeight: FontWeight.w400),
                                  suffixIconConstraints:
                                      const BoxConstraints(maxHeight: 30),
                                  suffixIcon: Padding(
                                    padding: context.paddingLowRightLow,
                                    child: ImageSvg(
                                      path: ImagePath.microphone.path,
                                      color:
                                          ColorConstants.instance.shadowplanet,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              );
                            },
                          ),
                        ),
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
                                      padding: context.paddingLowRight,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 32,
                                            backgroundColor: cubitRead
                                                .essentials[index].color,
                                            child: cubitRead
                                                .essentials[index].imagePath,
                                          ),
                                          context.lowSizedBox,
                                          LocaleText(
                                            text: cubitRead
                                                .essentials[index].title,
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
                              height: context.screenHeight / 3,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 8,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 0.70,
                                          crossAxisSpacing: 25,
                                          mainAxisSpacing: 15),
                                  itemBuilder: (BuildContext context, index) {
                                    return Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 32,
                                          backgroundColor:
                                              cubitRead.vegatables[index].color,
                                          child: cubitRead
                                              .vegatables[index].imagePath,
                                        ),
                                        context.lowSizedBox,
                                        SizedBox(
                                          width: context.veryHighValue,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: LocaleText(
                                              text: cubitRead
                                                  .vegatables[index].title,
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
                                text: LocaleKeys.vegatables,
                              ),
                            ),
                            context.normalSizedBox,
                            SizedBox(
                              height: context.screenHeight / 3,
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 8,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 0.70,
                                  ),
                                  itemBuilder: (BuildContext context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 32,
                                          backgroundColor:
                                              cubitRead.vegatables[index].color,
                                          child: cubitRead
                                              .vegatables[index].imagePath,
                                        ),
                                        context.lowSizedBox,
                                        SizedBox(
                                          width: context.veryHighValue,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: LocaleText(
                                              text: cubitRead
                                                  .vegatables[index].title,
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
                            )
                          ],
                        ),
                      ]),
                    )),
              ),
            ));
  }

  final List<SerachModel> searchList = [
    SerachModel(
      title: 'egg',
      image: ImageSvg(
        path: ImagePath.egg.path,
        height: 24,
      ),
      type: 'Essentials',
    ),
    SerachModel(
        title: 'banana',
        image: ImageSvg(
          path: ImagePath.egg.path,
          height: 24,
        ),
        type: 'Vegatable'),
    SerachModel(
        title: 'apple',
        image: ImageSvg(
          path: ImagePath.fish.path,
          height: 24,
        ),
        type: 'Essentials'),
    SerachModel(
        title: 'bread',
        image: ImageSvg(
          path: ImagePath.bread.path,
          height: 24,
        ),
        type: 'vega'),
    SerachModel(
        title: 'water',
        image: ImageSvg(
          path: ImagePath.milk.path,
          height: 24,
        ),
        type: 'vega'),
  ];
}

