import 'package:flutter/material.dart';
import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.dart';
import 'package:flutter_comic/share/util/format_util.dart';
import 'package:flutter_comic/view/navigator/hi_navigator.dart';
import 'package:flutter_comic/view/widget/share/image.dart';

///视频卡片
class FeedComicCard extends StatelessWidget {
  final ComicMo comicMo;

  const FeedComicCard({Key key, this.comicMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(comicMo.title);
          HiNavigator.getInstance()
              .jumpTo(RouteStatus.comic_detail, args: {"comic_id": comicMo.id});
        },
        child: SizedBox(
          height: 270,
          child: Card(
            //取消卡片默认边距
            margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_itemImage(context), _infoText()],
              ),
            ),
          ),
        ));
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(comicMo.cover, width: size.width / 2 - 10, height: 230),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
              decoration: BoxDecoration(
                  //渐变
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent])),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconText(
                      Icons.local_fire_department, countFormat(comicMo.num)),
                  Text(
                    comicMo.status,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  // _iconText(Icons.ondemand_video, videoMo.view),
                  // _iconText(Icons.favorite_border, videoMo.favorite),
                  // _iconText(null, videoMo.duration),
                ],
              ),
            ))
      ],
    );
  }

  _iconText(IconData iconData, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData, color: Colors.white, size: 12),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        )
      ],
    );
  }

  // _iconText(IconData iconData, int count) {
  //   String views = "";
  //   if (iconData != null) {
  //     views = countFormat(count);
  //   } else {
  //     views = durationTransform(comicMo.duration);
  //   }
  //   return Row(
  //     children: [
  //       if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
  //       Padding(
  //           padding: EdgeInsets.only(left: 3),
  //           child: Text(views,
  //               style: TextStyle(color: Colors.white, fontSize: 10)))
  //     ],
  //   );
  // }

  _infoText() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            comicMo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          //作者
          // _owner()
        ],
      ),
    ));
  }

  // _owner() {
  //   var owner = videoMo.owner;
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           ClipRRect(
  //               borderRadius: BorderRadius.circular(12),
  //               child: cachedImage(owner.face, height: 24, width: 24)),
  //           Padding(
  //             padding: EdgeInsets.only(left: 8),
  //             child: Text(
  //               owner.name,
  //               style: TextStyle(fontSize: 11, color: Colors.black87),
  //             ),
  //           )
  //         ],
  //       ),
  //       Icon(
  //         Icons.more_vert_sharp,
  //         size: 15,
  //         color: Colors.grey,
  //       )
  //     ],
  //   );
  // }
}
