import 'package:flutter/material.dart';
import 'package:flutter_comic/view/navigator/hi_navigator.dart';
import 'package:flutter_comic/view/pages/bottom_navigator.dart';
import 'package:flutter_comic/view/pages/log.dart';

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator.getInstance().setRouteJumpHandler((routeStatus, {args}) {
      _routeStatus = routeStatus;
      // if (routeStatus == RouteStatus.detail) {
      // this.videoModel = args['videoMo'];
      // }
      notifyListeners();
    });
    //设置网络错误拦截器
    // HiNet.getInstance().setErrorInterceptor((error) {
    //   if (error is NeedLogin) {
    //     //清空失效的登录令牌
    //     HiCache.getInstance().setString(LoginDao.BOARDING_PASS, null);
    //     //拉起登录
    //     HiNavigator.getInstance().onJumpTo(RouteStatus.login);
    //   }
    // });
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  // VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }
    // if (routeStatus == RouteStatus.home) {
    //   //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
    //   pages.clear();
    //   page = pageWrap(BottomNavigator());
    // } else if (routeStatus == RouteStatus.detail) {
    //   page = pageWrap(VideoDetailPage(videoModel));
    // } else if (routeStatus == RouteStatus.registration) {
    //   page = pageWrap(RegistrationPage());
    // } else if (routeStatus == RouteStatus.login) {
    //   page = pageWrap(LoginPage());
    // }

    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async => !await navigatorKey.currentState.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          // if (route.settings is MaterialPage) {
          //登录页未登录返回拦截
          // if ((route.settings as MaterialPage).child is LoginPage) {
          //   if (!hasLogin) {
          //     showWarnToast("请先登录");
          //     return false;
          //   }
          // }
          // }
          //执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //通知路由发生变化
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  // 拦截将要跳转的页面
  RouteStatus get routeStatus {
    return _routeStatus;
    // if (_routeStatus != RouteStatus.registration && !hasLogin) {
    //   return _routeStatus = RouteStatus.login;
    // } else if (videoModel != null) {
    //   return _routeStatus = RouteStatus.detail;
    // } else {
    //   return _routeStatus;
    // }
  }

  // bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}
}

///定义路由数据，path
class BiliRoutePath {
  // final String location;

  // BiliRoutePath.home() : location = "/";

  // BiliRoutePath.detail() : location = "/detail";
}
