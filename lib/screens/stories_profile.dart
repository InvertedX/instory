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
    final storiesBloc = BlocProvider.of<StoriesBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            new Container(
                              height: 280,
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
                              alignment: Alignment(12, 12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))),
                              height: 120,
                            ),
                            Container(
                                alignment: Alignment(120, 40), child: Hero(tag: profile.id, child: UserProfile(profile))),
                          ],
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: StreamBuilder(
                      initialData: List<Tray>(),
                      stream: storiesBloc.storiesArchive,
                      builder: (BuildContext context, AsyncSnapshot<List<Tray>> snap) {
                        return Container(child:
                        StoriesArchiveTray(snap.data));
                      })),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(top: 43),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))),
                    child: StreamBuilder(
                        initialData: List<Items>(),
                        stream: storiesBloc.stories,
                        builder: (BuildContext context, AsyncSnapshot<List<Items>> snap) {
                          return Container(margin: EdgeInsets.symmetric(horizontal: 2), child: StoriesReel(snap.data));
                        }),
                  )),

            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(bottom: 16,right: 12),
            child: FloatingActionButton(
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
          )
        ],
      ),
    );
  }
}
