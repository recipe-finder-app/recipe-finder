import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/enum/hive_enum.dart';
import '../../../core/init/cache/hive_manager.dart';
import '../../../product/model/user_model.dart';
import '../service/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<ILoginState> implements IBaseViewModel {
 
  ILoginService? service;
  LoginCubit() : super(LoginInit());

  @override
  void init() {
   
    service = LoginService();
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {}

  void login(String userName,String password) async {
    try {
     
        final response = await service!.login(userName, password);
        if (response!.data?.success != null) {
          if (response!.data!.success == true) {
            final IHiveManager<User> hiveManager = HiveManager<User>(HiveBoxEnum.userModel);
            await hiveManager.openBox();
            await hiveManager.put(
                HiveKeyEnum.user,
                User(
                  id: response.data!.data!.id!,
                  username: response.data!.data!.username!,
                  email: response.data!.data!.email!,
                  password: password,
                  token: response.data!.token!,
                ));
            final user = await hiveManager.get(HiveKeyEnum.user);
            print(user?.username.toString());
            print(response.data!.token);
            NavigationService.instance.navigateToPageClear(path: NavigationConstants.NAV_CONTROLLER);
          } else if (response.data!.success == false) {
            print('kullanıcı adı veya şifre yanlış');
          }
        } else if (response.error!.description != null) {
          print('response.error!.description ${response.error!.description}');
        }
        
      
     
    } catch (e) {
      throw Exception(e);
    }
  }

  void register(String userName,email,password) async {
    try {
     
        final response = await service!.register(userName,email,password);
        if (response!.data?.data != null) {
          if (response!.data!.data != null) {
            print(response.data!.token);
          } else if (response.data!.success == false) {
            print(response.data?.message);
          }
        } else if (response.error!.description != null) {
          print('response.error!.description ${response.error!.description}');
        }
      
     
    } catch (e) {
      print(e);
    }
  }



  /*Future<bool?> createToken() async {
    try {
      if (createTokenFormKey!.currentState!.validate()) {
        final response = await service!.createToken(emailController.text);
        if (response.data!.success == true) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }*/

 /* Future<TokenVerificationResponseModel?> tokenVerification(String email) async {
    try {
      if (tokenVerificationFormKey!.currentState!.validate()) {
        final response = await service!.tokenVerification(email, userNameController.text, passwordController.text);
        print(response.data?.message);
        return response.data;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }*/
}