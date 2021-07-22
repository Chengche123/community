import 'package:flutter/material.dart';
import 'package:flutter_comic/server/app-view/api/app.view.v1.api.pb.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry padding;

  const HiBanner(this.bannerList,
      {Key key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      //自定义指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white70, size: 6, activeSize: 8)),
    );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        print(bannerMo);
        _handleClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: [
              Image.network(bannerMo.cover, fit: BoxFit.cover),
              Positioned(
                child: Text(
                  bannerMo.title,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                bottom: 8,
                left: 10,
              )
            ],
            fit: StackFit.expand,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerMo bannerMo) {
    // if (bannerMo.type == 'video') {
    //   HiNavigator.getInstance().jumpTo(RouteStatus.detail,
    //       args: {'videoMo': VideoMo(vid: bannerMo.url)});
    // } else {
    //   print('type:${bannerMo.type} ,url:${bannerMo.url}');
    //   //todo
    // }
  }
}
