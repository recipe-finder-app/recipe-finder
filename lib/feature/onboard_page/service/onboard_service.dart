import '../../../core/constant/app/url/url_service/url_service.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../../../core/init/network/http/http_manager.dart';
import '../model/department_model.dart';
import '../model/department_response_model.dart';
import '../model/onboard_model.dart';
import '../model/onboard_response_model.dart';

abstract class IOnboardService {
  Future<OnboardResponseModel> fetchRegisterResponse(
      OnboardModel model, OnboardResponseModel responseModel);
  Future<List<DepartmentResponseModel>> fetchDepartmentList(
      DepartmentModel model, DepartmentResponseModel responseModel);
}

class OnboardService implements IOnboardService {
  CacheManager localeManager = CacheManager.instance;
  HttpManager? networkManager = HttpManager.instance;

  @override
  Future<OnboardResponseModel> fetchRegisterResponse(
      OnboardModel model, OnboardResponseModel responseModel) async {
    final response = await networkManager!
        .response<OnboardModel, OnboardResponseModel>(
            model, responseModel, UrlService.instance.registerUrl);
    print("gelen response data:${response.data}");
    return response.data;
  }

  @override
  Future<List<DepartmentResponseModel>> fetchDepartmentList(
      DepartmentModel model, DepartmentResponseModel responseModel) async {
    final response = await networkManager!
        .response<DepartmentModel, DepartmentResponseModel>(
            model, responseModel, UrlService.instance.departmentsUrl);
    print("gelen response data:${response.data}");
    return response.data;
  }
}
