import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/home_page/view/home_view.dart';

import 'fab_widget.dart';

class BottomNavbar extends StatefulWidget {
  final int pageid;
  const BottomNavbar({Key? key, required this.pageid}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight * 0.10,
      padding: EdgeInsets.only(top: context.screenHeight / 100),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: context.screenWidth * 0.08,
          ),
          item(
            icon: 'home',
            title: 'Home',
            pageName: 'homeView',
            id: 0,
          ),
          SizedBox(
            width: context.screenWidth * 0.08,
          ),
          item(
            icon: 'world',
            title: 'Discover',
            pageName: 'discoverView',
            id: 1,
          ),
          SizedBox(
            width: context.screenWidth * 0.25,
          ),
          item(
            icon: 'heart',
            title: 'Likes',
            pageName: 'likesView',
            id: 2,
          ),
          SizedBox(
            width: context.screenWidth * 0.10,
          ),
          item(
            icon: 'shopping_bag',
            title: 'Basket',
            pageName: 'basketView',
            id: 3,
          ),
          SizedBox(
            width: context.screenWidth * 0.08,
          ),
        ],
      ),
    );
  }

  Widget item({
    required String title,
    required String icon,
    required String pageName,
    required int id,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          isClick = false;
        });
        id != 0
            ? Navigator.pushNamedAndRemoveUntil(
                context, "/$pageName", (route) => false)
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ));
      },
      child: Column(
        children: [
          SvgPicture.asset('asset/navigation_bar_icon/$icon.svg',
              height: 25,
              color:
                  widget.pageid == id ? const Color(0xff1F1346) : Colors.grey),
          Text(
            title,
            style: TextStyle(
              color:
                  widget.pageid == id ? const Color(0xff1F1346) : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
