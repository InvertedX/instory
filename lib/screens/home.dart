import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stories/bloc/block_provider.dart';
import 'package:stories/bloc/stories_bloc.dart';
import 'package:stories/models.dart';
import 'package:stories/screens/widgets/user_profile_widget.dart';
import 'package:stories/utils/api.dart';
import 'package:stories/utils/colors.dart';
import 'package:stories/wave_clipper.dart';

import 'stories_profile.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  bool loading = false;
  bool fetchingStories = false;
  ApiResponse profile;
  TextEditingController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  HighLightsResponse _highLightsResponse;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 400,
                  child: ClipPath(
                      clipper: WaveClipper(),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [instaRed, instaViolet])),
                      )),
                ),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  margin: EdgeInsets.symmetric(horizontal: 44),
                  child: Card(
                    elevation: 22,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
                    child: TextField(
                      controller: _controller,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[500]),
                              borderRadius: BorderRadius.circular(30.0)),
                          enabledBorder: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                          ),
                          filled: true,
                          prefixIcon: InkWell(
                            child: Container(
                              child: Image.asset(
                                'assets/instagram.png',
                                scale: 2.5,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                          suffixIcon: Container(
                            padding: EdgeInsets.only(right: 4),
                            child: FloatingActionButton(
                              heroTag: "_MAIN_FAB_",
                              mini: true,
                              elevation: 0,
                              backgroundColor: instaRed,
                              onPressed: () {
                                fetchData(context);
                              },
                              child: loading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(instaLtYellow),
                                      strokeWidth: 3,
                                    )
                                  : Icon(Icons.arrow_forward),
                            ),
                          ),
                          hintStyle: new TextStyle(color: Colors.grey[500]),
                          hintText: "instagram username",
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                profile != null
                    ? InkWell(
                        onTap: () {
                          routeToProfile();
                        },
                        child: Hero(
                          child: UserProfile(profile),
                          tag: profile.id,
                        ))
                    : Container(),
                fetchingStories
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Fetching stories..."),
                          Container(
                            width: 18,
                            margin: EdgeInsets.only(left: 12),
                            height: 18,
                            alignment: Alignment(0, 0),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        ],
                      )
                    : Container(height: 40)
              ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchData(BuildContext context) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    String username = _controller.text;
    if (username.trim().length == 0) {
      return;
    }

    setState(() {
      loading = true;
    });
    try {
      profile = await Api.getProfile(username);
      setState(() {
        loading = false;
        fetchingStories = true;
      });

      _highLightsResponse = await Api.getHighLights(username);
      setState(() {
        fetchingStories = false;
      });
      routeToProfile();
    } catch (error) {
      setState(() {
        loading = false;
        fetchingStories = false;
      });
      if (error is NotFoundException) {
        showSnackBar("No account found");
      } else {
        showSnackBar("Unable to load data from api, please check your internet");
      }
    }
  }

  routeToProfile() {
    var st = BlocProvider(
      bloc: StoriesBloc(profile, _highLightsResponse),
      child: StoriesProfile(profile),
    );
    Navigator.of(context).push(
      PageRouteBuilder<Null>(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: st,
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 600)),
    );
  }

  showSnackBar(string) {
    final snackBar = SnackBar(content: Text(string));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
