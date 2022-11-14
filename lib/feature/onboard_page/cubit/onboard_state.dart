import 'package:motaperp_sosyal/view/onboard/model/department_response_model.dart';

abstract class IOnboardState {
  IOnboardState();
}

class OnboardInit extends IOnboardState {
  OnboardInit();
}

class OnCompleting extends IOnboardState {
  late bool isLoading;
  OnCompleting(isLoading);
}

class ChangeCurrentIndex extends IOnboardState {
  late int index;
  ChangeCurrentIndex(index);
}

class ChangeDropdownValue extends IOnboardState {
  late String id;
  late String name;
  ChangeDropdownValue(this.id, this.name);
}

class DepartmentListLoaded extends IOnboardState {
  List<DepartmentResponseModel>? myList;
  DepartmentListLoaded(this.myList);
}

class JOnboardError extends IOnboardState {
  String errorMessage;
  JOnboardError(this.errorMessage);
}
