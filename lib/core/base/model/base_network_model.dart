abstract class IBaseNetworkModel<T> {
  Map<String, Object?> toJson();
  T fromJson(Map<String, dynamic> json);
}
