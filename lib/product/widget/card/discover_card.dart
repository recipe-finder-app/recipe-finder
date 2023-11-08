import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';
import 'package:recipe_finder/product/service/common_service.dart';
import 'package:recipe_finder/product/utils/enum/hive_enum.dart';
import 'package:recipe_finder/product/widget/container/circular_bacground.dart';

import '../../../core/init/cache/hive_manager.dart';
import '../../../core/init/language/language_manager.dart';
import '../../model/user/user_model.dart';
import '../../utils/constant/image_path_enum.dart';
import '../../../core/widget/text/bold_text.dart';

class DiscoverCard extends StatefulWidget {
  DiscoverCard({super.key, required this.model, this.width, this.onPressed, this.likeIconOnPressed});
 final Recipe model;
  final double? width;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? likeIconOnPressed;
  @override
  State<DiscoverCard> createState() => _DiscoverCardState();
}

class _DiscoverCardState extends State<DiscoverCard> {
   Future<UserModel?> fetchCacheUserModel() async {
     IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
      final user = await hiveManager.get(HiveKeyEnum.user);
      return user;
   }
  
  final ICommonService commonService = CommonService();
  @override
  Widget build(BuildContext context) {
     String recipeName = context.locale == LanguageManager.instance.trLocale ? (widget.model.nameTR ?? '') : (widget.model.nameEN ?? '');
    return InkWell(
      onTap:widget.onPressed,
      child: Stack(
        children: [
          recipeImage(context),
          likeImage(context),
          Padding(
            padding: context.paddingLowAll,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BoldText(
                text: recipeName,
                textColor: ColorConstants.instance.white,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
                fontSize: 12,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox recipeImage(BuildContext context) {

    return SizedBox(
      width: widget.width ?? context.screenWidth / 1.3,
      child: Container(
        decoration: BoxDecoration(
          image:(widget.model.imagePath!=null && widget.model.imagePath!.isNotEmpty) ? DecorationImage(
              fit: BoxFit.cover,
              image:NetworkImage(widget.model.imagePath!),
              ) : DecorationImage(
              fit: BoxFit.cover,
              image:AssetImage(ImagePathConstant.imageSample1.path)
              ),
          borderRadius: context.radiusAllCircularMin,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.radiusBottomCircularMin,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0, 0.6, 1],
              colors: [
                Colors.black,
                Colors.transparent,
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding likeImage(BuildContext context) {
    return Padding(
      padding: context.paddingNormalAll,
      child: Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: () async {
           final user = await fetchCacheUserModel();
           final isRecipeContainsInLikedRecipeList = await commonService.isContainsRecipeInLikedRecipelist(user!.id!, widget.model.id ?? "0");
           if(widget.likeIconOnPressed!=null){
           widget.likeIconOnPressed!.call(isRecipeContainsInLikedRecipeList);
           setState(() {            
           });
           }
          },
          child:FutureBuilder(
            future: fetchCacheUserModel(),
            builder: (context,userSnapShot){
              if(userSnapShot.data!=null){
                return  FutureBuilder(
              future: commonService.isContainsRecipeInLikedRecipelist(userSnapShot.data!.id!, widget.model.id ?? "0"),
               builder: (context,snapshot){
                 if(snapshot.data!=null && snapshot.data==true){
                return CircularBackground(
                    circleHeight: 35,
                    circleWidth: 35,
                    child: Icon(
                      Icons.favorite_outlined,
                      color: ColorConstants.instance.white,
                      size: 18,
                    ),
                  );
                 }
                 else {
                  return CircularBackground(
                    circleHeight: 35,
                    circleWidth: 35,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: ColorConstants.instance.white,
                      size: 18,
                    ),
                  );
                 }
               });
              }
              else {
                 return CircularBackground(
                    circleHeight: 35,
                    circleWidth: 35,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: ColorConstants.instance.white,
                      size: 18,
                    ),
                  );
              }
            
            }
          ),
        ),
      ),
    );
  }
}

