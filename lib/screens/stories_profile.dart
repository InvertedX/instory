import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stories/bloc/block_provider.dart';
import 'package:stories/bloc/stories_bloc.dart';
import 'package:stories/utils/colors.dart';
import 'package:stories/models.dart';
import 'package:stories/screens/widgets/stories_reel.dart';
import 'package:stories/screens/widgets/stories_tray.dart';
import 'package:stories/screens/widgets/user_profile_widget.dart';

//// ignore: must_be_immutable
//class StoriesProfile extends StatefulWidget {
//  StoriesProfile();
//
//  @override
//  State<StatefulWidget> createState() => new _StoriesProfile();
//}

class StoriesProfile extends StatelessWidget {
  ApiResponse profile;

  StoriesProfile(this.profile);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 128;
    double topSection = height / 2.7;
    double storySection = height - topSection;
    final storiesBloc = BlocProvider.of<StoriesBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        heroTag: "_MAIN_FAB_",
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.white,
        elevation: 12,
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.grey[700],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: topSection,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Container(
                              height: topSection,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new NetworkImage(profile.user.profilePicUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: new BackdropFilter(
                                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: new Container(
                                  decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))),
                              height: 120,
                            ),
                            Container(child: Hero(tag: profile.id, child: UserProfile(profile))),
                          ],
                        ),
                      ],
                    ),
                  )),
              Container(
                  height: 124,
                  child: StreamBuilder(
                      initialData: List<Tray>(),
                      stream: storiesBloc.storiesArchive,
                      builder: (BuildContext context, AsyncSnapshot<List<Tray>> snap) {
                        return Container(child: StoriesArchiveTray(snap.data));
                      })),
              Container(
                height: storySection,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))),
                child: StreamBuilder(
                    initialData: List<Items>(),
                    stream: storiesBloc.stories,
                    builder: (BuildContext context, AsyncSnapshot<List<Items>> snap) {
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: StoriesReel(snap.data, storySection - 40));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
