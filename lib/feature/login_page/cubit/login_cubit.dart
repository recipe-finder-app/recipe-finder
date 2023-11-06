import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/base_response_model.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import '../../../core/base/model/base_view_model.dart';
import '../../../core/init/cache/hive_manager.dart';
import '../../../product/model/user/user_model.dart';
import '../../../product/utils/enum/hive_enum.dart';
import '../service/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> implements IBaseViewModel {
 
  ILoginService? service;
    LoginCubit() : super(const LoginState(isLoading: false));


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
Future<BaseResponseModel> signIn(String userNameOrEmail,password) async{
  try{
   final user = await service!.signInWithEmailOrUserName(userNameOrEmail, password);
   if(user!=null){
     final IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
            await hiveManager.put(
                HiveKeyEnum.user,
                UserModel(
                  id: user.id,
                  userName: user.userName,
                  email: user.email,
                  password: user.password,
                  uid: user.uid,
                  token:user.token,
                  profilePhotoUrl: user.profilePhotoUrl,
                ));
               final hiveUser = await hiveManager.get(HiveKeyEnum.user);
                print("id ${hiveUser?.id}");
const responseModel = BaseResponseModel(success: true,message: "Giriş başarılı!");
 emit(state.copyWith(responseModel: responseModel));
  return  responseModel;
   }
   else {
    final responseModel = BaseResponseModel(success: false,error: BaseError(message: LocaleKeys.invalidUserNameOrPassword.locale));
 emit(state.copyWith(responseModel: responseModel));
  return  responseModel;
   }
 

}
on FirebaseAuthException catch(e){
  final responseModel = BaseResponseModel(success: false,error: BaseError(message: e.message ?? ''));
  emit(state.copyWith(responseModel: responseModel));
  print(e.message);
  return responseModel;
}
}
Future<BaseResponseModel> signUp(String userName,email,password) async{
  try{
 await service!.signUp(userName, email, password);
 const responseModel = BaseResponseModel(success: true);
 emit(state.copyWith(responseModel: responseModel));
 return  responseModel;
}
on FirebaseAuthException catch(e){
  String errorMessage = '';
  BaseResponseModel? responseModel;
  if(e.code=='weak-password') {
     errorMessage = "Zayıf şifre";
    responseModel = BaseResponseModel(success: false,error: BaseError(message: errorMessage));
     emit(state.copyWith(responseModel: responseModel));
  return responseModel;
  }
  else if(e.code=='email-already-in-use'){
  errorMessage = "Bu kullanıcı zaten kayıtlı";
    responseModel = BaseResponseModel(success: false,error: BaseError(message: errorMessage));
     emit(state.copyWith(responseModel: responseModel));
    return responseModel;
  }
  else {
errorMessage = e.message ?? '';
    responseModel = BaseResponseModel(success: false,error: BaseError(message: errorMessage));
     emit(state.copyWith(responseModel: responseModel));
    return responseModel;
  }
 
 
}
}
  /*void login(String userName,String password) async {
    try {
     
        final response = await service!.login(userName, password);
        if (response!.data?.success != null) {
          if (response!.data!.success == true) {
            final IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
            await hiveManager.openBox();
            await hiveManager.put(
                HiveKeyEnum.user,
                UserModel(
                  id: response.data!.data!.id!,
                  userName: response.data!.data!.username!,
                  email: response.data!.data!.email!,
                  password: password,
                  token: response.data!.token!,
                ));
            final user = await hiveManager.get(HiveKeyEnum.user);
            print(user?.userName.toString());
            print(response.data!.token);
            NavigationService.instance.navigateToPageClear(path: NavigationConstant.NAV_CONTROLLER);
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
  }*/



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
  }

  Future<TokenVerificationResponseModel?> tokenVerification(String email) async {
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