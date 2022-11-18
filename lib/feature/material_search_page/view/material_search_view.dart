import 'package:flutter/material.dart';

import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';

import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';

import 'package:recipe_finder/feature/material_search_page/cubit/material_cubit.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/app_bar/text_app_bar.dart';
import 'package:recipe_finder/product/widget/search/search_widget.dart';

class MaterialSearchView extends StatelessWidget {
  const MaterialSearchView({
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
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            child: Column(
              children: [
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
                SearchWidget(
                  width: context.veryValueWidth,
                  onChanged: () {},
                ),
                context.mediumSizedBox,
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
                                    backgroundColor:
                                        cubitRead.essentials[index].color,
                                    child:
                                        cubitRead.essentials[index].imagePath,
                                  ),
                                  context.lowSizedBox,
                                  LocaleText(
                                    text: cubitRead.essentials[index].title,
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
                                  child: cubitRead.vegatables[index].imagePath,
                                ),
                                context.lowSizedBox,
                                SizedBox(
                                  width: context.veryHighValue,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: LocaleText(
                                      text: cubitRead.vegatables[index].title,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor:
                                      cubitRead.vegatables[index].color,
                                  child: cubitRead.vegatables[index].imagePath,
                                ),
                                context.lowSizedBox,
                                SizedBox(
                                  width: context.veryHighValue,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: LocaleText(
                                      text: cubitRead.vegatables[index].title,
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
              ],
            ),
          ),
        )),
      ),
    );
  }
}
