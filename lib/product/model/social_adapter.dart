import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/model/user/user_model.dart';

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
    return SocialAdapterModel(title: LocaleKeys.loginWithApple.locale, color: Colors.black, icon: const Icon(FontAwesomeIcons.apple));
  }
}

abstract class ISocialAdapter {
  late final SocialAdapterModel model;
  Future<UserModel> login();
  Future<void> signOut();
}

class GoogleAdapter implements ISocialAdapter {
  GoogleSignIn get googleSignIn {
    if (Platform.isIOS) {
      return GoogleSignIn(clientId: '822676919477-r938lul4181p5p01l02di7l5tad4fmik.apps.googleusercontent.com');
    } else {
      return GoogleSignIn();
    }
  
  }

  @override
  Future<UserModel> login() async {
    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        throw 'Google sign in user is null';
      } else {
        final authentication = await user.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken:authentication.idToken,
        );

       final response = await FirebaseAuth.instance.signInWithCredential(credential);

        return UserModel(email: response.user?.email,uid:response.user?.uid,token:response.credential?.token.toString(),);
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
  Future<UserModel> login() async 
  {
    return UserModel();
   /* try {
      final login = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);
      if (login.status == LoginStatus.success) {
        final user = await FacebookAuth.instance.getUserData();
        final email = user["email"];
        final name = user["name"];
        final picture = user["picture"]["data"]["url"];
        print(email);
        print(name);
        print(picture);
        print(login.accessToken?.toJson());
        return user.toString();
      } else {
        return 'Facebook sign in user is null';
      }
    } catch (error) {
      print(error);
      return '$error';
    }*/
  }

  @override
  SocialAdapterModel model = SocialAdapterModel.facebook();

  @override
  Future<void> signOut() async {
   // await FacebookAuth.instance.logOut();
  }
}

class AppleAdapter implements ISocialAdapter {
  @override
  Future<UserModel> login() async 
  {
    return UserModel();
   /* try {
      final login = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);
      if (login.status == LoginStatus.success) {
        final user = await FacebookAuth.instance.getUserData();
        final email = user["email"];
        final name = user["name"];
        final picture = user["picture"]["data"]["url"];
        print(email);
        print(name);
        print(picture);
        print(login.accessToken?.toJson());
        return user.toString();
      } else {
        return 'Facebook sign in user is null';
      }
    } catch (error) {
      print(error);
      return '$error';
    }*/
  }

  @override
  SocialAdapterModel model = SocialAdapterModel.apple();

  @override
  Future<void> signOut() async {
   // await FacebookAuth.instance.logOut();
  }
}