import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comic/conf/view/color.dart';
import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.dart';
import 'package:flutter_comic/server/app-view/api/dio.dart';
import 'package:flutter_comic/share/util/toast.dart';
import 'package:flutter_comic/view/widget/share/banner.dart';
import 'package:flutter_comic/view/widget/share/comic_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_comic/view/state/hi_state.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo> bannerList;

  const HomeTabPage({Key key, this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends HiState<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List<ComicMo> comicList = [];
  int pageIndex = 0;
  bool _loading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      // print('dis:$dis');
      //当距离底部不足300时加载更多
      if (dis < 300 && !_loading) {
        print('------_loadData---');
        _loadData(loadMore: true);
      }
    });
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _loadData,
      color: primary,
      child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: StaggeredGridView.countBuilder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              crossAxisCount: 2,
              itemCount: comicList.length,
              itemBuilder: (BuildContext context, int index) {
                //有banner时第一个item位置显示banner
                if (widget.bannerList != null && index == 0) {
                  return Padding(
                      padding: EdgeInsets.only(bottom: 8), child: _banner());
                } else {
                  if (widget.categoryName == "推荐") {
                    index--;
                  }
                  return FeedComicCard(comicMo: comicList[index]);
                }
              },
              staggeredTileBuilder: (int index) {
                if (widget.bannerList != null && index == 0) {
                  return StaggeredTile.fit(2);
                } else {
                  return StaggeredTile.fit(1);
                }
              })),
    );
  }

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: HiBanner(widget.bannerList));
  }

  Future<void> _loadData({loadMore = false}) async {
    _loading = true;
    if (!loadMore) {
      pageIndex = 0;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print('loading:currentIndex:$currentIndex');
    try {
      ListHomeMoResponse res = await AppviewServiceClientProxy.getInstance()
          .listHomeMo(
              ListHomeMoRequest(
                  categoryName: widget.categoryName,
                  pageIndex: currentIndex,
                  pageSize: 10),
              null);
      setState(() {
        if (loadMore) {
          if (res.comicList.isNotEmpty) {
            //合成一个新数组
            comicList = [...comicList, ...res.comicList];
            pageIndex++;
          }
        } else {
          comicList = res.comicList;
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        _loading = false;
      });
    } on DioError catch (e) {
      showWarnToast(
          '接口返回失败: ${e.error} ${e.response?.statusCode} ${e.response?.data}');
      _loading = false;
    } catch (e) {
      print("homt_tab_page._loadData: $e");
    }

    // try {
    //   HomeMo result = await HomeDao.get(widget.categoryName,
    //       pageIndex: currentIndex, pageSize: 10);
    //   setState(() {
    //     if (loadMore) {
    //       if (result.videoList.isNotEmpty) {
    //         //合成一个新数组
    //         videoList = [...videoList, ...result.videoList];
    //         pageIndex++;
    //       }
    //     } else {
    //       videoList = result.videoList;
    //     }
    //   });
    //   Future.delayed(Duration(milliseconds: 1000), () {
    //     _loading = false;
    //   });
    // } on NeedAuth catch (e) {
    //   _loading = false;
    //   print(e);
    //   showWarnToast(e.message);
    // } on HiNetError catch (e) {
    //   _loading = false;
    //   print(e);
    //   showWarnToast(e.message);
    // }
  }

  @override
  bool get wantKeepAlive => widget.categoryName == "推荐" ? true : false;
}
