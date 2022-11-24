import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key, required this.onChanged, required this.width})
      : super(key: key);
  VoidCallback? onChanged;
  double width;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: ColorConstants.instance.white,
        border: Border.all(
            color: ColorConstants.instance.roboticgods.withOpacity(0.9),
            width: 2.0,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
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
      ),
    );
  }
}
