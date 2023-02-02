import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';

class SocialAdapterModel {
  final String title;
  final Color color;
  final Icon icon;
  SocialAdapterModel({required this.title, required this.color, required this.icon});
  factory SocialAdapterModel.google() {
    return SocialAdapterModel(
        title: 'Sign in with Google',
        color: ColorConstants.instance.googleColor,
        icon: Icon(
          FontAwesomeIcons.googlePlusG,
          color: ColorConstants.instance.googleColor,
        ));
  }
  factory SocialAdapterModel.facebook() {
    return SocialAdapterModel(title: 'Sign in with Facebook', color: ColorConstants.instance.facebookColor, icon: Icon(FontAwesomeIcons.facebook, color: ColorConstants.instance.facebookColor));
  }
  factory SocialAdapterModel.apple() {
    return SocialAdapterModel(title: 'Sign in with Apple', color: Colors.black, icon: Icon(FontAwesomeIcons.apple));
  }
}

abstract class ISocialAdapter {
  late final SocialAdapterModel model;
  Future<String> fetchResponse();
}

class GoogleAdapter implements ISocialAdapter {
  @override
  Future<String> fetchResponse() {
    // TODO: implement fetchResponse
    throw UnimplementedError();
  }

  @override
  SocialAdapterModel model = SocialAdapterModel.google();
}

class FacebookAdapter implements ISocialAdapter {
  @override
  Future<String> fetchResponse() {
    // TODO: implement fetchResponse
    throw UnimplementedError();
  }

  @override
  SocialAdapterModel model = SocialAdapterModel.facebook();
}
