import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motaperp_sosyal/core/constant/enum/locale_keys_enum.dart';
import 'package:motaperp_sosyal/core/constant/navigation/navigation_constants.dart';
import 'package:motaperp_sosyal/core/init/cache/locale_manager.dart';
import 'package:motaperp_sosyal/core/init/navigation/navigation_service.dart';
import 'package:motaperp_sosyal/core/widget/message/toast_message.dart';
import 'package:motaperp_sosyal/view/onboard/model/onboard_model.dart';
import 'package:motaperp_sosyal/view/onboard/model/onboard_response_model.dart';

import '../../../core/base/model/base_view_model.dart';
import '../model/department_model.dart';
import '../model/department_response_model.dart';
import '../service/onboard_service.dart';
import 'onboard_state.dart';

class OnboardCubit extends Cubit<IOnboardState> implements IBaseViewModel {
  List<OnboardModel> onboardItems = [];
  bool completing = false;
  int currentIndex = 0;

  PageController pageController = PageController(initialPage: 0);
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController tfNameController;
  late TextEditingController tfUserNameController;
  late TextEditingController tfPasswordController;
  String? selectedDepartment;
  String? selectedDepartmentId;
  List<DepartmentResponseModel> departmentList = [];

  IOnboardService? service;
  OnboardCubit() : super(OnboardInit());
  @override
  void init() {
    tfNameController = TextEditingController();
    tfUserNameController = TextEditingController();
    tfPasswordController = TextEditingController();
    service = OnboardService();
    clear();
    onboardItems.add(OnboardModel(pageType: OnboardPageType.name));
    onboardItems.add(OnboardModel(pageType: OnboardPageType.department));
    onboardItems.add(OnboardModel(pageType: OnboardPageType.idPass));
    fetchDepartmentList();
  }

  void changeDropdownValue(
    String selectedValueName,
    List<String> itemIdList,
    List<String> itemList,
  ) {
    int currentIndex = itemList.indexOf(selectedValueName);
    selectedDepartmentId = itemList[currentIndex];
    selectedDepartment = selectedValueName;
    emit(ChangeDropdownValue(selectedDepartmentId!, selectedDepartment!));
  }

  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void dispose() {
    CacheManager.instance.clearAll();
  }

  void onCompleting() {
    completing = !completing;
    emit(OnCompleting(completing));
  }

  Future<void> onComplete() async {
    try {
      onCompleting();
      if (selectedDepartment != null &&
          tfNameController.text.isNotEmpty &&
          tfPasswordController.text.isNotEmpty &&
          tfUserNameController.text.isNotEmpty) {
        final response = await service!.fetchRegisterResponse(
            OnboardModel(
                nameSurname: tfNameController.text,
                departmentId: selectedDepartmentId,
                userName: tfUserNameController.text,
                password: tfPasswordController.text),
            OnboardResponseModel());

        if (response.success == 1) {
          if (kDebugMode) {
            print(response.success);
          }
          CacheManager.instance
              .setStringValue(PreferencesKeys.department, selectedDepartment!);
          CacheManager.instance.setStringValue(
              PreferencesKeys.nameSurname, tfNameController.text);
          CacheManager.instance.setStringValue(
              PreferencesKeys.userName, tfUserNameController.text);
          CacheManager.instance.setStringValue(
              PreferencesKeys.password, tfPasswordController.text);
          NavigationService.instance
              .navigateToPage(path: NavigationConstants.LOGIN);
          formKey.currentState!.reset();
        } else if (response.error!.message != null) {
          ToastMessage.instance
              .errorMessage(errorMessage: response.error!.message);
        }
      } else {
        ToastMessage.instance.errorMessage(
            errorMessage: 'Lütfen sayfalardaki tüm alanları doldurunuz!');
      }
    } catch (e) {
      ToastMessage.instance.errorMessage(errorMessage: e.toString());
    } finally {
      onCompleting();
    }
  }

  Future<void> fetchDepartmentList() async {
    try {
      onCompleting();
      final response = await service!
          .fetchDepartmentList(DepartmentModel(), DepartmentResponseModel());
      departmentList = response;
      emit(DepartmentListLoaded(departmentList));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ToastMessage.instance
          .errorMessage(errorMessage: 'Bir hata meydana geldi!');
    } finally {
      onCompleting();
    }
  }

  void changeCurrentIndex(int value) {
    if (value >= 0 && value < onboardItems.length) {
      currentIndex = value;
      pageController.animateToPage(value,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      emit(ChangeCurrentIndex(currentIndex));
    }
  }

  void clear() {
    onboardItems = [];
    completing = false;
    currentIndex = 0;
    pageController = PageController(initialPage: 0);
    formKey = GlobalKey<FormState>();
    tfNameController.clear();
    tfUserNameController.clear();
    tfPasswordController.clear();
    selectedDepartment = null;
    selectedDepartmentId = null;
    departmentList = [];
  }

  @override
  NavigationService navigation = NavigationService.instance;
  @override
  CacheManager localeManager = CacheManager.instance;
}
