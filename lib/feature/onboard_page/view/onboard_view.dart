import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motaperp_sosyal/core/constant/app/url/url_icon/url_icon.dart';
import 'package:motaperp_sosyal/core/constant/design/color_constant.dart';
import 'package:motaperp_sosyal/core/extension/context_extension.dart';
import 'package:motaperp_sosyal/core/widget/SizedBox/sized_box_height_veryHigh.dart';
import 'package:motaperp_sosyal/core/widget/drop_down_button/dropdown_search_button.dart';
import 'package:motaperp_sosyal/core/widget/loading/progress_fading_circle.dart';

import '/core/base/view/base_view.dart';
import '/view/onboard/cubit/onboard_cubit.dart';
import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/widget/text_field/text_form_field_login.dart';
import '../../../core/widget/text_field/text_form_field_password.dart';
import '../cubit/onboard_state.dart';
import '../model/onboard_model.dart';

class OnboardView extends StatelessWidget {
  final nameSurnameText = 'İsim soyisim girin';
  final userNameText = 'Kullanıcı adı belirleyin';
  final passwordText = 'Şifre belirleyin';
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      dispose: (cubitRead) => cubitRead.dispose(),
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorConstants.instance.customGrey2Color,
        body: WillPopScope(
          onWillPop: () => NavigationService.instance.quitApp(),
          child: SingleChildScrollView(
            child: Container(
              height: context.screenHeight,
              color: ColorConstants.instance.customGrey2Color,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: context.screenHeight / 12, left: 20, right: 20),
                  child: BlocBuilder<OnboardCubit, IOnboardState>(
                      builder: (BuildContext context, state) {
                    return Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigationService.instance.navigateToPage(
                                    path: NavigationConstants.LOGIN);
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xFFfabf00),
                                      size: 40,
                                    ),
                                    Text('Giriş Yap'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: context.screenHeight / 12,
                            ),
                            Image.asset(
                              ImageUrl.instance.motapUrl,
                              height: 150,
                              width: 150,
                            ),
                            buildContent(cubitRead, cubitWatch,
                                cubitRead.onboardItems, state),
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FloatingActionButton(
                                    backgroundColor:
                                        ColorConstants.instance.customBlueColor,
                                    onPressed: () {
                                      cubitRead.changeCurrentIndex(
                                          cubitRead.currentIndex - 1);
                                    },
                                    child: Tooltip(
                                      message: 'Geri',
                                      child: Icon(
                                        Icons.keyboard_arrow_left,
                                        color: ColorConstants
                                            .instance.customGreyColor,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: context.paddingLow,
                                        child: CircleAvatar(
                                          backgroundColor: ColorConstants
                                              .instance.customBlueColor,
                                          radius:
                                              index == cubitRead.currentIndex
                                                  ? 20
                                                  : 10,
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  FloatingActionButton(
                                    backgroundColor:
                                        ColorConstants.instance.customBlueColor,
                                    onPressed: cubitWatch.completing == true
                                        ? null
                                        : () {
                                            if (cubitRead.currentIndex ==
                                                cubitRead.onboardItems.length -
                                                    1) {
                                              cubitRead.onComplete();
                                            } else {
                                              cubitRead.changeCurrentIndex(
                                                  cubitRead.currentIndex + 1);
                                            }
                                          },
                                    child: Tooltip(
                                      message: cubitRead.currentIndex ==
                                              cubitRead.onboardItems.length - 1
                                          ? 'Bitir'
                                          : 'İleri',
                                      child: Icon(
                                        cubitRead.currentIndex ==
                                                cubitRead.onboardItems.length -
                                                    1
                                            ? Icons.check
                                            : Icons.keyboard_arrow_right,
                                        color: ColorConstants
                                            .instance.customGreyColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        cubitWatch.completing == true
                            ? const ModalBarrier(
                                dismissible: false,
                              )
                            : const Center(),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Flexible buildContent(OnboardCubit cubitRead, OnboardCubit cubitWatch,
      List<OnboardModel> modelList, IOnboardState state) {
    return Flexible(
      flex: 4,
      child: Form(
        key: cubitWatch.formKey,
        child: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.passthrough,
          children: [
            PageView.builder(
                controller: cubitRead.pageController,
                itemCount: cubitRead.onboardItems.length,
                onPageChanged: (value) async {
                  cubitRead.changeCurrentIndex(value);
                },
                itemBuilder: (context, index) {
                  if (cubitRead.onboardItems[index].pageType ==
                      OnboardPageType.name) {
                    return TextFormFieldLogin(
                      hintText: nameSurnameText,
                      tfController: cubitRead.tfNameController,
                    );
                  } else if (cubitRead.onboardItems[index].pageType ==
                      OnboardPageType.department) {
                    return CustomDropDownSearchButton(
                      selectedItem: cubitWatch.selectedDepartment,
                      mode: Mode.BOTTOM_SHEET,
                      labelText: 'Şube seçin',
                      validator: true,
                      itemNameList: cubitRead.departmentList
                          .map((e) => e.department!)
                          .toList(),
                      onChanged: (String? selectedData) {
                        cubitRead.changeDropdownValue(
                            selectedData!,
                            cubitRead.departmentList.map((e) => e.id!).toList(),
                            cubitRead.departmentList
                                .map((e) => e.department!)
                                .toList());
                      },
                    );
                  } else if (cubitRead.onboardItems[index].pageType ==
                      OnboardPageType.idPass) {
                    return Column(
                      children: [
                        TextFormFieldLogin(
                          hintText: userNameText,
                          tfController: cubitRead.tfUserNameController,
                        ),
                        const SizedBoxHeightVeryHigh(),
                        TextFormFieldPassword(
                          hintText: passwordText,
                          tfController: cubitRead.tfPasswordController,
                        ),
                      ],
                    );
                  } else {
                    return TextFormFieldLogin(
                      hintText: nameSurnameText,
                    );
                  }
                }),
            cubitWatch.completing == true
                ? const ProgressFadingCircle()
                : const Center(),
          ],
        ),
      ),
    );
  }
}
