import 'package:flutter/material.dart';
import 'package:flutter_comic/view/pages/bottom_navigator.dart';
import 'package:flutter_comic/view/pages/log.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo pre);
typedef RouteJumpHandler(RouteStatus routeStatus, {Map args});

///创建页面
pageWrap(Widget rawPage) {
  return MaterialPage(key: ValueKey(rawPage.hashCode), child: rawPage);
}

///获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getMPageStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///自定义路由封装，路由状态
enum RouteStatus { login, home, detail, unknown }

///获取page对应的RouteStatus
RouteStatus getMPageStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else {
    return RouteStatus.unknown;
  }
  // if (page.child is LoginPage) {
  //   return RouteStatus.login;
  // } else if (page.child is RegistrationPage) {
  //   return RouteStatus.registration;
  // } else if (page.child is BottomNavigator) {
  //   return RouteStatus.home;
  // } else if (page.child is VideoDetailPage) {
  //   return RouteStatus.detail;
  // } else {
  //   return RouteStatus.unknown;
  // }
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator {
  static HiNavigator _instance;

  RouteJumpHandler _routeJumpHandler;

  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo _current;

  HiNavigator._();
  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance;
  }

  //首页底部tab
  RouteStatusInfo _bottomTab;

  ///首页底部tab切换监听
  void bottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab);
  }

  ///注册路由跳转逻辑
  void setRouteJumpHandler(RouteJumpHandler routeJumpListener) {
    this._routeJumpHandler = routeJumpListener;
  }

  void jumpTo(RouteStatus routeStatus, {Map args}) {
    _routeJumpHandler(routeStatus, args: args);
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  ///移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(
        getMPageStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.rawPage is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab;
    }
    print('hi_navigator:current:${current.rawPage}');
    print('hi_navigator:pre:${_current?.rawPage}');
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget rawPage;

  RouteStatusInfo(this.routeStatus, this.rawPage);
}
