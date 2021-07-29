import 'package:flutter/material.dart';
import 'package:flutter_comic/view/widget/video/video_view.dart';

///排行
class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Scaffold(
          appBar: AppBar(),
          body: VideoView("http://127.0.0.1/367042343-1-208.mp4"),
        ),
      ),
    );
  }
}
