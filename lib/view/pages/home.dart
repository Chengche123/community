import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comic/conf/view/color.dart';
import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.dart';
import 'package:flutter_comic/server/app-view/api/dio.dart';
import 'package:flutter_comic/share/util/toast.dart';
import 'package:flutter_comic/view/navigator/hi_navigator.dart';
import 'package:flutter_comic/view/pages/home_tab_page.dart';
import 'package:flutter_comic/view/state/hi_state.dart';
import 'package:flutter_comic/view/widget/share/navigation-bar.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  final ValueChanged onAvatar;

  const HomePage({Key key, this.onAvatar}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RouteChangeListener listener;
  TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('home:current:${current.rawPage}');
      print('home:pre:${pre?.rawPage}');
      if (widget == current.rawPage || current.rawPage is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.rawPage || pre?.rawPage is HomePage) {
        print('首页:onPause');
      }
    });
    _loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          NavigationBar(
            statusStyle: StatusStyle.DARK_CONTENT,
            child: _appBar(),
            height: 50,
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: _tabBar(),
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _controller,
                  children: categoryList.map<HomeTabPage>((category) {
                    return HomeTabPage(
                      category.name,
                      bannerList: category.name == "推荐" ? bannerList : null,
                    );
                  }).toList()))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  ///自定义顶部tab
  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary, width: 3),
            insets: EdgeInsets.only(left: 15, right: 15)),
        tabs: categoryList.map<Tab>((category) {
          return Tab(
              child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              category.name,
              style: TextStyle(fontSize: 16),
            ),
          ));
        }).toList());
  }

  _loadData() async {
    try {
      ListHomeMoResponse res = await AppviewServiceClientProxy.getInstance()
          .listHomeMo(ListHomeMoRequest(), null);
      setState(() {
        categoryList = res.categoryList;
        bannerList = res.bannerList;
        _controller = TabController(length: categoryList.length, vsync: this);
      });
    } on DioError catch (e) {
      showWarnToast('接口返回失败: ${e.response?.statusCode} ${e.response?.data}');
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onAvatar != null) widget.onAvatar(3);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage("images/avatar.png"),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              padding: EdgeInsets.only(left: 15),
              height: 32,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16)),
            ),
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(16),
            //   child: Container(
            //     padding: EdgeInsets.only(left: 10),
            //     height: 32,
            //     alignment: Alignment.centerLeft,
            //     child: Icon(
            //       Icons.search,
            //       color: Colors.grey,
            //     ),
            //     decoration: BoxDecoration(color: Colors.grey[100]),
            //   ),
            // ),
          )),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
