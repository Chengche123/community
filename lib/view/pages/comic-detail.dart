import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.dart';
import 'package:flutter_comic/server/app-view/api/dio.dart';
import 'package:flutter_comic/share/util/date.dart';
import 'package:flutter_comic/view/widget/share/image.dart';
import 'package:flutter_comic/view/widget/share/toast.dart';

class ComicDetailPage extends StatefulWidget {
  final int comicId;

  const ComicDetailPage({Key key, this.comicId}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ComicDetail _detail;
  bool _loading = false;
  bool _noCopyright = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _detail != null
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(),
                title: Text(_detail.title),
                actions: [
                  IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () async {}),
                  PopupMenuButton<String>(
                    itemBuilder: (e) => [
                      PopupMenuItem<String>(
                          value: 'download', child: new Text('下载')),
                      PopupMenuItem<String>(
                          value: 'share', child: new Text('分享漫画')),
                    ],
                    icon: Icon(Icons.more_vert),
                    onSelected: (e) {
                      if (e == "share") {
                      } else {}
                    },
                  )
                ],
                bottom: TabBar(
                    tabs: [Tab(text: "详情"), Tab(text: "评论"), Tab(text: "相关")]),
              ),
              body: TabBarView(
                children: [
                  _detailTabPage(),
                  SizedBox(
                    height: 400,
                  ),
                  SizedBox(
                    height: 400,
                  )
                ],
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              actions: [],
            ),
            body: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(24),
                    child: Text(_noCopyright
                        ? "漫画ID:${widget.comicId}\r\n因版权、国家法规等原因，该漫画暂时无法观看。"
                        : ""),
                  ),
          );
  }

  Widget _detailTabPage() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        child: cachedImage(_detail.cover),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _detail.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "作者:" + _detail.authors,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "点击:" + _detail.hotNum.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "订阅:" + _detail.subscribeNum.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "状态:" + _detail.status,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "最后更新:" +
                                  DateUtil.formatDate(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(_detail.lastUpdatetime
                                                  .toString()) *
                                              1000),
                                      format: "yyyy-MM-dd"),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Wrap(
                      children: _detail.types
                          .split('/')
                          .map<Widget>((f) => _createTagItem(f))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    color: Theme.of(context).cardColor,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("简介",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          _detail.description,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  ComicChapterView(
                    widget.comicId,
                    _detail,
                    null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {},
      ),
    );
  }

  Widget _createTagItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ButtonTheme(
        height: 30,
        child: OutlineButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textColor: Theme.of(context).accentColor,
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          child: Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
          onPressed: () {
            //  Utils.openPage(context, id, 11, title: text);
          },
        ),
      ),
    );
  }

  void loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      ListComicDetailResponse detail1 =
          await AppviewServiceClientProxy.getInstance().listComicDetail(
              ListComicDetailRequest(
                comicIds: [widget.comicId],
              ),
              null);
      setState(() {
        _detail = detail1.comics[0];
        print(detail1.comics[0].cover);
      });
    } on DioError catch (e) {
      showWarnToast('接口返回失败: ${e.response?.statusCode} ${e.response?.data}');
    } catch (e) {
      print("catch error: $e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}

class ComicChapterView extends StatefulWidget {
  final ComicDetail detail;
  final int comicId;
  final bool isSubscribe;
  final int historyChapter;
  final Function openReader;
  ComicChapterView(this.comicId, this.detail, this.historyChapter,
      {Key key, this.isSubscribe = false, this.openReader})
      : super(key: key);

  @override
  _ComicChapterViewState createState() => _ComicChapterViewState();
}

class _ComicChapterViewState extends State<ComicChapterView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.detail.chapters != null && widget.detail.chapters.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 12),
            physics: ScrollPhysics(),
            itemCount: widget.detail.chapters.length,
            itemBuilder: (ctx, i) {
              var f = widget.detail.chapters[i];
              return Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                                f.title +
                                    "(共" +
                                    f.data.length.toString() +
                                    "话)",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (f.desc) {
                                f.data.sort((x, y) =>
                                    x.chapterOrder.compareTo(y.chapterOrder));
                              } else {
                                f.data.sort((x, y) =>
                                    y.chapterOrder.compareTo(x.chapterOrder));
                              }
                              f.desc = !f.desc;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(f.desc ? "排序 ↓" : "排序 ↑"),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount:
                          f.data.length > 14 ? (f.showNum + 1) : f.data.length,
                      padding: EdgeInsets.all(2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width ~/ 120,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 6 / 2),
                      itemBuilder: (context, i) {
                        if (f.data.length > 14 && f.showNum == 14 && i >= 14) {
                          return OutlineButton(
                            onPressed: () {
                              setState(() {
                                f.showNum = f.data.length - 1;
                              });
                            },
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.4)),
                            child: Text("· · ·"),
                          );
                        }
                        return OutlineButton(
                          borderSide: BorderSide(
                              color:
                                  f.data[i].chapterId == widget.historyChapter
                                      ? Theme.of(context).accentColor
                                      : Colors.grey.withOpacity(0.4)),
                          child: Text(
                            f.data[i].chapterTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    f.data[i].chapterId == widget.historyChapter
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color),
                          ),
                          onPressed: () {
                            // Utils.openComicReader(
                            //     context,
                            //     widget.comicId,
                            //     widget.detail.title,
                            //     widget.isSubscribe,
                            //     f.data,
                            //     f.data[i]);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 8)
                  ],
                ),
              );
            })
        : Container(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text("岂可修！竟然没有可以看的章节！"),
            ),
          );
  }

  void openRead() async {
    // if (widget.detail == null ||
    //     widget.detail.chapters == null ||
    //     widget.detail.chapters.length == 0 ||
    //     widget.detail.chapters[0].data.length == 0) {
    //   Fluttertoast.showToast(msg: '没有可读的章节');
    //   return;
    // }
    // if (widget.historyChapter != 0) {
    //   ComicDetailChapterInfoResponse _item;
    //   ComicDetailChapterResponse chpters;
    //   for (var item in widget.detail.chapters) {
    //     var first = item.data.firstWhere(
    //         (f) => f.chapterId == widget.historyChapter,
    //         orElse: () => null);
    //     if (first != null) {
    //       chpters = item;
    //       _item = first;
    //     }
    //   }
    //   if (_item != null) {
    //     Utils.openComicReader(context, widget.comicId, widget.detail.title,
    //         widget.isSubscribe, chpters.data, _item);
    //     return;
    //   }
    // }
    // Utils.openComicReader(
    //     context,
    //     widget.comicId,
    //     widget.detail.title,
    //     widget.isSubscribe,
    //     widget.detail.chapters[0].data,
    //     widget.detail.chapters[0].data.last);
  }
}
