import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constant/design/color_constant.dart';
import '../cubit/recipe_detail_cubit.dart';

class LandscapePlayerView extends StatefulWidget {
  final VideoPlayerController controller;
  const LandscapePlayerView({Key? key, required this.controller})
      : super(key: key);

  @override
  State<LandscapePlayerView> createState() => _LandscapePlayerViewState();
}

class _LandscapePlayerViewState extends State<LandscapePlayerView> {
  Future _landscapeMode() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Future _setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _landscapeMode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _setAllOrientation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          InkWell(
              onTap: () {
                context.read<RecipeDetailCubit>().clickRunVideoButton();
              },
              child: VideoPlayer(widget.controller)),
          /* InkWell(
            onTap: () {
              context.read<RecipeDetailCubit>().clickRunVideoButton();
            },
            child: Icon(
              widget.controller.value.isPlaying
                  ? Icons.pause
                  : Icons.play_circle_outline,
              color: Colors.white,
              size: 25,
            ),
          ),*/
          Positioned(
            top: 25,
            left: 25,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 5,
            child: IconButton(
              icon: const Icon(
                Icons.fullscreen_exit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 25,
            right: 50,
            left: 50,
            child: VideoProgressIndicator(widget.controller,
                colors: VideoProgressColors(
                    backgroundColor: ColorConstants.instance.brightGraySolid,
                    playedColor: Colors.white),
                allowScrubbing: true),
          ),
        ],
      ),
    );
  }
}
