import 'package:flutter/material.dart';
import 'package:stories/models.dart';
import 'package:stories/screens/story_details_pager.dart';

class StoriesReel extends StatelessWidget {
  List<Items> stories;

  double height;

  StoriesReel(this.stories, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          itemCount: this.stories.length,
          itemBuilder: (BuildContext context, int index) {
            return new _StoriesReel(index, stories,this.height);
          }),
    );
  }
}

class _StoriesReel extends StatelessWidget {
  int story;
  List<Items> stories;

  double height;

  _StoriesReel(this.story, this.stories, this.height);

  @override
  Widget build(BuildContext context) {
    var item = this.stories[story];
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StoryDetails(story, this.stories)),
              );
            },
            highlightColor: Colors.grey[300],
            child: Material(
              elevation: 1,
              color: Colors.grey[400],
              borderRadius: BorderRadius.all(new Radius.circular(6)),
              clipBehavior: Clip.hardEdge,
              child: Hero(
                transitionOnUserGestures: true,
                tag: item.id,
                child: new Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: this.height,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                    image: new NetworkImage(item.imageVersions2.candidates[5].url

                     ),
                  )),
                ),
//                child: Container(
//                  decoration: BoxDecoration(shape: BoxShape.rectangle),
//                  child: Image.network(
//                    item.imageVersions2.candidates[5].url,
//                    height: double.infinity,
//                  ),
//                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTapItem() {}
}
