import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

class AutoCompleteWidget extends StatelessWidget {
  AutoCompleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.veryValueWidth,
      decoration: BoxDecoration(
        color: ColorConstants.instance.white,
        border: Border.all(
            color: ColorConstants.instance.roboticgods.withOpacity(0.9),
            width: 2.0,
            style: BorderStyle.solid),
        borderRadius: context.radiusAllCircularMin,
      ),
      child: Autocomplete<IngredientModel>(
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<IngredientModel>.empty();
          }
          Iterable<IngredientModel> iterable = searchList.where(
            (element) => element.title.contains(textEditingValue.text),
          );
          return iterable.isNotEmpty ? iterable : [IngredientModel(title: '')];
        },
        onSelected: (value) {},
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<IngredientModel> onSelected,
            Iterable<IngredientModel> options) {
          final list = options.toList();
          String firsType = list.first.type ?? '';

          for (var i = 1; i < list.length; i++) {
            !firsType.contains(list[i].type!)
                ? firsType = '$firsType + ${list[i].type!}'
                : '';
          }
          return Padding(
            padding: context.paddingLowOnlyTop,
            child: Scaffold(
              body: options.first.title == null
                  ? const Center(
                      child: LocaleText(
                        text: 'Aranan isimde ürün bulunamadı',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          context.normalSizedBox,
                          Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: list.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, index) {
                                  return Column(
                                    children: [
                                      CircleAvatar(
                                          radius: 32,
                                          backgroundColor: list[index].color,
                                          child: ImageSvg(
                                            path: list[index].imagePath ?? '',
                                          )),
                                      context.lowSizedBox,
                                      SizedBox(
                                        width: context.veryHighValue,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: LocaleText(
                                            text: list[index].title,
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
                        ]),
            ),
          );
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: ImageSvg(
                  path: ImagePath.searchh.path,
                  color: ColorConstants.instance.russianViolet),
              hintText: LocaleKeys.search,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.instance.roboticgods,
                  fontWeight: FontWeight.w400),
              suffixIconConstraints: const BoxConstraints(maxHeight: 30),
              suffixIcon: Padding(
                padding: context.paddingLowRightLow,
                child: ImageSvg(
                  path: ImagePath.microphone.path,
                  color: ColorConstants.instance.russianViolet,
                ),
              ),
            ),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          );
        },
      ),
    );
  }

  final List<IngredientModel> searchList = [
    IngredientModel(
        imagePath: ImagePath.egg.path,
        title: LocaleKeys.egg,
        type: 'Essentials',
        color: const Color(0xff968960).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.milk.path,
        title: LocaleKeys.milk,
        type: 'Essentials',
        color: const Color(0xff127aa7).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.bread.path,
        title: LocaleKeys.bread,
        type: 'Essentials',
        color: const Color(0xffb7690d).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.tomato.path,
        title: LocaleKeys.tomato,
        type: 'Vegatables',
        color: const Color(0xffa30909).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.salad.path,
        title: LocaleKeys.salad,
        type: 'Vegatables',
        color: const Color(0xff519e1b).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.potato.path,
        title: LocaleKeys.potato,
        type: 'Vegatables',
        color: const Color(0xffb7690d).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.onion.path,
        title: LocaleKeys.onion,
        type: 'Vegatables',
        color: const Color(0xff9d5622).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.broccoli.path,
        title: LocaleKeys.broccoli,
        type: 'Vegatables',
        color: const Color(0xff1a5b22).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.carrot.path,
        title: LocaleKeys.carrot,
        type: 'Vegatables',
        color: const Color(0xffa44703).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.eggplant.path,
        title: LocaleKeys.eggplant,
        type: 'Vegatables',
        color: const Color(0xff800771).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.peas.path,
        title: LocaleKeys.peas,
        type: 'Vegatables',
        color: const Color(0xff61980a).withOpacity(0.1)),
    IngredientModel(
        imagePath: ImagePath.peas.path,
        title: LocaleKeys.peas,
        type: 'Vegatables',
        color: const Color(0xff61980a).withOpacity(0.1)),
  ];
}
