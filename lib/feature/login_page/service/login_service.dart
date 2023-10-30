import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_finder/product/model/user/user_model.dart';
import 'package:recipe_finder/product/utils/enum/firebase_collection_enum.dart';

abstract class ILoginService {

 signInWithEmailOrUserName(String emailOrUserName, String password);
 signUp(String userName, String email, String password);

  /*Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password);
  Future<IResponseModel<RegisterResponseModel?, INetworkModel<dynamic>?>> register(String userName, String email, String password);
  Future<IResponseModel<CreateTokenResponseModel?, INetworkModel<dynamic>?>> createToken(String email);
  Future<IResponseModel<TokenVerificationResponseModel?, INetworkModel<dynamic>?>> tokenVerification(String Email, String verificationCode, String password);*/
}

class LoginService extends ILoginService {
  CollectionReference users = FirebaseFirestore.instance.collection(FirebaseCollectionEnum.users.name);
  @override
Future<UserModel?>  signInWithEmailOrUserName(String emailOrUserName, String password) async {
    final convertedUserModel =  users.withConverter(
      fromFirestore: (snapshot,options){
        final jsonBody = snapshot.data();
       
        if(jsonBody!=null) {
          return UserModel.fromJson(jsonBody)..copyWith(id: snapshot.id);
        }
      },
       toFirestore: (value,options){
        if (value == null) throw Exception('$value is null');
        return value.toJson();
       }
       );
       UserModel? userModel;
    if(emailOrUserName.contains('@')){
  final  credential =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailOrUserName, password: password);
  if(credential.user!=null){
   await convertedUserModel.where('email',isEqualTo: emailOrUserName).where('password',isEqualTo: password).limit(1).get().then((querySnapshot){
      if(querySnapshot.docs.isNotEmpty){
         final firestoreUserDocs = querySnapshot.docs;
       final firestoreUser = firestoreUserDocs.first.data();
final user = UserModel(userName: firestoreUser?.userName, email: emailOrUserName,password: password,token: credential.credential?.token.toString(),uid: credential.user?.uid,profilePhotoUrl:credential.user?.photoURL);
    userModel = user;
       }
    });
  }
    }
    else {
     await convertedUserModel.where('user_name',isEqualTo: emailOrUserName).where('password',isEqualTo: password).limit(1).get().then((querySnapshot){
      if(querySnapshot.docs.isNotEmpty){
       final firestoreUserDocs = querySnapshot.docs;
       final firestoreUser = firestoreUserDocs.first.data();
      final user = UserModel(
          userName: emailOrUserName,
          email:firestoreUser!.email,
          password: password,
          token: firestoreUser.token,
          uid: FirebaseAuth.instance.currentUser?.uid,
          profilePhotoUrl: firestoreUser.profilePhotoUrl,
        );
         userModel = user;
      }
  });
    }
    return userModel;
  }

  @override
 Future<void> signUp(String userName, String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((credential){
      _createUserInFirestore(userName: userName, email: email, password:password, uid:credential.user?.uid, photoURL: credential.user?.photoURL);

       /*final UserModel user = UserModel(userName: userName,email: credential.user?.email,password: password,uid: credential.user?.uid,profilePhotoUrl: credential.user?.photoURL);
    users.doc(email).set(user.toJson());
       });*/
  });
  
 }
  void _createUserInFirestore({required String userName,required String email,required String? password,required String? uid,required String? photoURL}){

    users.where('email',isEqualTo: FirebaseAuth.instance.currentUser?.email)
    .limit(1).get().then((querySnapshot){
     
      if(querySnapshot.docs.isEmpty){
         final UserModel user = UserModel(userName: userName,email:email,password: password,uid:uid,profilePhotoUrl:photoURL);
    users.doc(email).set(user.toJson());
      }
  });
  }



 /*
   @override
  Future<IResponseModel<LoginResponseModel?, INetworkModel<dynamic>?>> login(String email, String password) async {
    final response = VexanaManager.instance.networkManager.send<LoginResponseModel, LoginResponseModel>(ServicePathConstant.login, parseModel: LoginResponseModel(), method: RequestType.POST, data: LoginModel(username: email, password: password));
    return response;
  }

  Future<IResponseModel<RegisterResponseModel?, INetworkModel<dynamic>?>> register(String userName, String email, String password) async {
    final response = VexanaManager.instance.networkManager
        .send<RegisterResponseModel, RegisterResponseModel>(ServicePathConstant.register, parseModel: RegisterResponseModel(), method: RequestType.POST, data: RegisterModel(username: userName, email: email, password: password));
    return response;
  }

  @override
  Future<IResponseModel<CreateTokenResponseModel?, INetworkModel?>> createToken(String email) {
    final response = VexanaManager.instance.networkManager.send<CreateTokenResponseModel, CreateTokenResponseModel>(ServicePathConstant.resetPassword, parseModel: CreateTokenResponseModel(), method: RequestType.POST, data: CreateTokenModel(email: email));
    return response;
  }

  @override
  Future<IResponseModel<TokenVerificationResponseModel?, INetworkModel?>> tokenVerification(String email, String verificationCode, String password) {
    print('${ServicePathConstant.resetPassword}/$email/$verificationCode');
    final response = VexanaManager.instance.networkManager.send<TokenVerificationResponseModel, TokenVerificationResponseModel>('${ServicePathConstant.resetPassword}/$email/$verificationCode',
        parseModel: TokenVerificationResponseModel(), method: RequestType.POST, data: TokenVerificationModel(password: password));
    return response;
  }*/
}
