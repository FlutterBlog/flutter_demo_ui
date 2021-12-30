/*
 * flutter_ui_demo 
 * share_manager.dart 
 * 
 * Created by YueChen on 2021/12/22.
 */

class ShareManager {
  factory ShareManager() => _getInstance();

  static ShareManager get instance => _getInstance();
  static ShareManager? _instance;

  ShareManager._internal();

  static ShareManager _getInstance() {
    if (_instance == null) {
      _instance = ShareManager._internal();
      _instance?._configManager();
    }
    return _instance!;
  }

  //MARK:

  // 环境信息
  bool isRelease = true;
  String environment = "Online"; //测试环境 Test 线上环境 Online

  // 登录信息
  bool isLogin = false;
  String authToken = 'XXX';

  // 登录信息
  String someThing = 'someThing';

  //MARK: 初始化
  _configManager() {
    /// 初始化
    _appStart((isStart) => null);
  }

  //MARK: Public
  getData(Function(bool isSuccess) finishFunc) {
    //
  }

  //MARK: Private
  _appStart(Function(bool isStart) appStartFunc) {
    //
  }
}
