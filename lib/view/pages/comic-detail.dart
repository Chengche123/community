import 'package:flutter/material.dart';

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

  var _detail;
  bool _loading = false;
  bool _noCopyright = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _detail != null
        ? Container()
        : Scaffold(
            appBar: AppBar(),
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
}
