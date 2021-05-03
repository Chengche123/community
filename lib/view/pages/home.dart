import 'package:flutter/material.dart';
import 'package:flutter_comic/view/navigator/hi_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  RouteChangeListener listener;

  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('home:current:${current.rawPage}');
      print('home:pre:${pre?.rawPage}');
      if (widget == current.rawPage || current.rawPage is HomePage) {
        print('home:onResume');
      } else if (widget == pre?.rawPage || pre?.rawPage is HomePage) {
        print('home:onPause');
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: Text("首页"),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
