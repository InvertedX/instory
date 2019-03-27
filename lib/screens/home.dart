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
    double totalHeight = MediaQuery.of(context).size.height;
    double waveSection =totalHeight/2.5;

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: waveSection,
                    child: ClipPath(
                        clipper: WaveClipper(),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(gradient: LinearGradient(colors: [instaRed, instaViolet])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                              Image.asset("assets/Instory_white.png",width: 64,height: 64,),
                              Padding(
                                padding: const EdgeInsets.only(top: 22),
                                child: Text(
                                  "Instory",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "MoonlightsOnTheBeach",
                                     fontWeight: FontWeight.normal,
                                  ),
                                  textScaleFactor: 4,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Material(
                      elevation: 10,
                      shadowColor: Colors.grey[100],
                      type: MaterialType.card,
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
                  Container(
                    height: 200,
                    child: profile != null
                        ? Dismissible(
                            background: Container(
                              color: Colors.grey[200],
                            ),
                            onDismissed: (DismissDirection dis) {
                              setState(() {
                                profile = null;
                                loading = false;
                                fetchingStories = false;
                                _highLightsResponse = null;
                              });
                            },
                            key: Key("_KEY_"),
                            movementDuration: Duration(milliseconds: 120),
                            child: InkWell(
                                onTap: () {
                                  routeToProfile();
                                },
                                child: Hero(child: UserProfile(profile), tag: profile.id)),
                          )
                        : Container(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    margin: EdgeInsets.only(bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(fetchingStories ? "Fetching stories..." : ""),
                        fetchingStories
                            ? Container(
                                width: 18,
                                margin: EdgeInsets.only(left: 12),
                                height: 18,
                                alignment: Alignment(0, 0),
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Container()
                      ],
                    ),
                  )
                ]),
          ),
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
