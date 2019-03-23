import 'package:flutter/widgets.dart';
import 'package:stories/models.dart';

class ImageStory extends StatelessWidget {
  int index = 0;

  final int selectedItem;
  final Items story;

  ImageStory({
    Key key,
    @required this.selectedItem,
    @required this.story,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: index == selectedItem ? story.id : "",
        child: GestureDetector(
          onVerticalDragEnd: (DragEndDetails dwon) {
            if (dwon.primaryVelocity > 800) {
              Navigator.pop(context);
            }
          },
          child: FadeInImage(
            fit: BoxFit.fill,
            fadeInDuration:Duration(milliseconds: 900),
            fadeInCurve: ElasticInCurve(12),
            placeholder: NetworkImage(story.imageVersions2.candidates[5].url),
            image: NetworkImage(story.imageVersions2.candidates[2].url)),
          ),
        );
  }
}
