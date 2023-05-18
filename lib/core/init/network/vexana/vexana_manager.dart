import 'package:vexana/vexana.dart';

class VexanaManager {
  VexanaManager._init();
  static VexanaManager? _instance;
  static VexanaManager get instance {
    _instance ??= VexanaManager._init();
    return _instance!;
  }

  static const String _baseUrl = 'https://tarifiyle-bul.onrender.com/api';

  INetworkManager networkManager = NetworkManager<Null>(
    isEnableLogger: true,
    options: BaseOptions(baseUrl: _baseUrl),
  );
}
