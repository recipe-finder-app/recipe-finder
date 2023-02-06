import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';

import '../../core/init/language/locale_keys.g.dart';

class SocialAdapterModel {
  final String title;
  final Color color;
  final Icon icon;
  SocialAdapterModel({required this.title, required this.color, required this.icon});
  factory SocialAdapterModel.google() {
    return SocialAdapterModel(
        title: LocaleKeys.loginWithGoogle.locale,
        color: ColorConstants.instance.googleColor,
        icon: Icon(
          FontAwesomeIcons.googlePlusG,
          color: ColorConstants.instance.googleColor,
        ));
  }
  factory SocialAdapterModel.facebook() {
    return SocialAdapterModel(title: LocaleKeys.loginWithFacebook.locale, color: ColorConstants.instance.facebookColor, icon: Icon(FontAwesomeIcons.facebook, color: ColorConstants.instance.facebookColor));
  }
  factory SocialAdapterModel.apple() {
    return SocialAdapterModel(title: 'Sign in with Apple', color: Colors.black, icon: Icon(FontAwesomeIcons.apple));
  }
}

abstract class ISocialAdapter {
  late final SocialAdapterModel model;
  Future<String> login();
  Future<void> signOut();
}

class GoogleAdapter implements ISocialAdapter {
  final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '865687401723-ac4bulugmdj6ot4q3rs021q5mv6mi12g.apps.googleusercontent.com');
  @override
  Future<String> login() async {
    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        throw 'Google sign in user is null';
      } else {
        final GoogleSignInAuthentication? authentication = await user!.authentication;
        print(authentication?.accessToken);
        print(user.email);
        print(user.id);
        print(user.displayName);
        print(user.serverAuthCode);
        print(user.photoUrl);
        return user.email;
      }
    } catch (error) {
      throw '$error';
    }
  }

  @override
  SocialAdapterModel model = SocialAdapterModel.google();

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
  }
}

class FacebookAdapter implements ISocialAdapter {
  @override
  Future<String> login() {
    // TODO: implement fetchResponse
    throw UnimplementedError();
  }

  @override
  SocialAdapterModel model = SocialAdapterModel.facebook();

  @override
  Future<void> signOut() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
