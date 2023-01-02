import 'package:flutter/material.dart';

import '../../../core/constant/design/color_constant.dart';

class GoToTopFabButton extends StatefulWidget {
  final ScrollController scrollController;
  const GoToTopFabButton({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<GoToTopFabButton> createState() => _GoToTopFabButtonState();
}

class _GoToTopFabButtonState extends State<GoToTopFabButton> {
  bool _visible = false;

  @override
  void initState() {
    // TODO: implement initState
    widget.scrollController.addListener(() {
      if (widget.scrollController.offset >= 350) {
        setState(() {
          _visible = true;
        });
      } else {
        setState(() {
          _visible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: SizedBox(
        height: 45,
        width: 45,
        child: FloatingActionButton(
            elevation: 5,
            highlightElevation: 5,
            focusElevation: 5,
            hoverElevation: 5,
            disabledElevation: 5,
            backgroundColor: ColorConstants.instance.russianViolet,
            shape: CircleBorder(
                side: const BorderSide(
              color: Colors.transparent,
            )),
            onPressed: () {
              widget.scrollController.animateTo(0,
                  duration: Duration(milliseconds: 500), curve: Curves.easeOut);
            },
            child: Icon(
              Icons.arrow_drop_up,
              color: Colors.white,
              size: 45,
            )),
      ),
    );
  }
}
