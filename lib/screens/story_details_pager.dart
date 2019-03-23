import 'package:flutter/material.dart';
import 'package:stories/models.dart';
import 'package:stories/screens/widgets/story/common_story_layout.dart';
import 'package:video_player/video_player.dart';

class StoryDetails extends StatefulWidget {
  int selectedItem;
  List<Items> trays;

  StoryDetails(this.selectedItem, this.trays);

  @override
  State<StatefulWidget> createState() {
    return new _StoryDetails(selectedItem, trays);
  }
}

class _StoryDetails extends State<StoryDetails> {
  int selectedItem;
  List<Items> items;
  double bottomargin = 0;
  PageController _pageController;
  VideoPlayerController _controller;

  _StoryDetails(this.selectedItem, this.items);

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: selectedItem, keepPage: true, viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      itemBuilder: _pageBuilder,
      physics: BouncingScrollPhysics(),
      pageSnapping: true,
      onPageChanged: _onPageChange,
      controller: _pageController,
      itemCount: items.length,
    ));
  }

  Widget _pageBuilder(BuildContext context, int index) {
    Items story = items[index];
    return Story(story, index, selectedItem);
  }

  void _onPageChange(int value) {
    setState(() {
      selectedItem = value;
    });
  }
}
