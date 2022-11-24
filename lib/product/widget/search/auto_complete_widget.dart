import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';

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
      child: Autocomplete<ProductModel>(
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<ProductModel>.empty();
          }
          Iterable<ProductModel> iterable = searchList.where(
            (element) => element.title!.contains(textEditingValue.text),
          );
          return iterable.isNotEmpty ? iterable : [ProductModel()];
        },
        onSelected: (value) {},
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<ProductModel> onSelected,
            Iterable<ProductModel> options) {
          final list = options.toList();
          String firsType = list.first.type ?? '';

          for (var i = 1; i < list.length; i++) {
            !firsType.contains(list[i].type!)
                ? firsType = '$firsType + ${list[i].type!}'
                : '';
          }
          return SafeArea(
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
                          SizedBox(
                            height: context.screenHeight / 3,
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
                                        child: list[index].image,
                                      ),
                                      context.lowSizedBox,
                                      SizedBox(
                                        width: context.veryHighValue,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: LocaleText(
                                            text: list[index].title ?? '',
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
                  color: ColorConstants.instance.shadowplanet),
              hintText: 'Search',
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.instance.roboticgods,
                  fontWeight: FontWeight.w400),
              suffixIconConstraints: const BoxConstraints(maxHeight: 30),
              suffixIcon: Padding(
                padding: context.paddingLowRightLow,
                child: ImageSvg(
                  path: ImagePath.microphone.path,
                  color: ColorConstants.instance.shadowplanet,
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

  final List<ProductModel> searchList = [
    ProductModel(
        image: ImageSvg(
          path: ImagePath.egg.path,
          height: 24,
        ),
        title: LocaleKeys.egg,
        type: 'Essentials',
        color: const Color(0xff968960).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.milk.path,
          height: 24,
        ),
        title: LocaleKeys.milk,
        type: 'Essentials',
        color: const Color(0xff127aa7).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.bread.path,
          height: 24,
        ),
        title: LocaleKeys.bread,
        type: 'Essentials',
        color: const Color(0xffb7690d).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.tomato.path,
          height: 24,
        ),
        title: LocaleKeys.tomato,
        type: 'Vegatables',
        color: const Color(0xffa30909).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.salad.path,
          height: 24,
        ),
        title: LocaleKeys.salad,
        type: 'Vegatables',
        color: const Color(0xff519e1b).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.potato.path,
          height: 24,
        ),
        title: LocaleKeys.potato,
        type: 'Vegatables',
        color: const Color(0xffb7690d).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.onion.path,
          height: 24,
        ),
        title: LocaleKeys.onion,
        type: 'Vegatables',
        color: const Color(0xff9d5622).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.broccoli.path,
          height: 24,
        ),
        title: LocaleKeys.broccoli,
        type: 'Vegatables',
        color: const Color(0xff1a5b22).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.carrot.path,
          height: 24,
        ),
        title: LocaleKeys.carrot,
        type: 'Vegatables',
        color: const Color(0xffa44703).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.eggplant.path,
          height: 24,
        ),
        title: LocaleKeys.eggplant,
        type: 'Vegatables',
        color: const Color(0xff800771).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.peas.path,
          height: 24,
        ),
        title: LocaleKeys.peas,
        type: 'Vegatables',
        color: const Color(0xff61980a).withOpacity(0.1)),
    ProductModel(
        image: ImageSvg(
          path: ImagePath.peas.path,
          height: 24,
        ),
        title: LocaleKeys.peas,
        type: 'Vegatables',
        color: const Color(0xff61980a).withOpacity(0.1)),
  ];
}
