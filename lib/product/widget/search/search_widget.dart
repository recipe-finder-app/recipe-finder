import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.maxValueWidth,
      decoration: BoxDecoration(
        //  color: Theme.of(context).colorScheme.onSecondary,
        color: Colors.white,
        border: Border.all(
            color: Colors.grey, width: 2.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search_sharp, color: Colors.black),
            hintText: 'Search',
            suffixIconConstraints: const BoxConstraints(maxHeight: 30),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mic_none_rounded,
                color: Colors.black,
              ),
            )),
      ),
    );
  }
}
