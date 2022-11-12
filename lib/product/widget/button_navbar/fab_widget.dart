import 'package:flutter/material.dart';
import 'package:recipe_finder/feature/finder_page/view/finder_view.dart';
import 'package:flutter_svg/svg.dart';

class MyFAB extends StatefulWidget {
  const MyFAB({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFAB> createState() => _MyFABState();
}

class _MyFABState extends State<MyFAB> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      //alignment: const FractionalOffset(.5, 1.0),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
                backgroundColor:
                    isClick ? const Color(0xff1F1346) : Colors.pink,
                onPressed: () {
                  setState(() {
                    isClick = true;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FinderView()));
                },
                child:
                    SvgPicture.asset('asset/navigation_bar_icon/search.svg')
                    ,),
            SizedBox(
              height: size.height * .03,
            ),
            Text(
              'Finder',
              style: TextStyle(
                color: isClick ? const Color(0xff1F1346) : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

bool isClick = false;
