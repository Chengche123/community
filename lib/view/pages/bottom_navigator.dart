import 'package:flutter/material.dart';
import 'package:flutter_comic/conf/view/color.dart';
import 'package:flutter_comic/view/navigator/hi_navigator.dart';
import 'package:flutter_comic/view/pages/favorite.dart';
import 'package:flutter_comic/view/pages/comic-home.dart';
import 'package:flutter_comic/view/pages/profile.dart';
import 'package:flutter_comic/view/pages/video.dart';

///底部导航
class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = mprimary;
  int _currentIndex = 0;
  static int initialPage = 0;
  final PageController _controller = PageController(initialPage: initialPage);
  List<Widget> _pages;
  bool _hasBuild = false;

  @override
  Widget build(BuildContext context) {
    _pages = [
      ComicPage(
        onJumpTo: (value) {
          _jumpTo(value, pageChange: false);
        },
      ),
      VideoPage(),
      FavoritePage(),
      ProfilePage()
    ];
    if (!_hasBuild) {
      //页面第一次打开时通知打开的是那个tab
      HiNavigator.getInstance()
          .bottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: (index) => _jumpTo(index, pageChange: true),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _jumpTo(index, pageChange: false),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('漫画', Icons.book, 0),
          _bottomItem('视频', Icons.live_tv, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.home, 3),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
        label: title);
  }

  void _jumpTo(int index, {bool pageChange = false}) {
    if (!pageChange) {
      //让PageView展示对应tab
      _controller.jumpToPage(index);
    } else {
      HiNavigator.getInstance().bottomTabChange(index, _pages[index]);
    }
    setState(() {
      //控制选中第一个tab
      _currentIndex = index;
    });
  }
}
