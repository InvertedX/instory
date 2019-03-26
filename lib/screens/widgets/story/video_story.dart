import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stories/models.dart';
import 'package:video_player/video_player.dart';

class VideoStory extends StatefulWidget {
  int index = 0;
  int selectedItem;
  Items story;
  VideoStory({
    Key key,
    @required this.selectedItem,
    @required this.story,
    @required this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoStory(selectedItem: selectedItem, story: story, index: index);
}

class _VideoStory extends State<VideoStory> {
  int index = 0;
  VideoPlayerController _controller;
  int selectedItem;
  Items story;

  _VideoStory({
    Key key,
    this.selectedItem,
    this.story,
    this.index,
  });

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(this.story.videoVersions[1].url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: index == selectedItem ? this.story.id : "",
        child: GestureDetector(
            onVerticalDragEnd: (DragEndDetails dwon) {
              if (dwon.primaryVelocity > 800) {
                Navigator.pop(context);
              }
            },
            child: _controller.value.initialized
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ],
                  )
                : Container(
                    child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      FadeInImage(
                          fit: BoxFit.cover,
                          fadeInDuration: Duration(milliseconds: 100),
                          placeholder: NetworkImage(story.imageVersions2.candidates[5].url),
                          image: NetworkImage(story.imageVersions2.candidates[2].url)),
                      Center(child: CircularProgressIndicator())
                    ],
                  ))));
  }
}
