import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stories/models.dart';

class UserProfile extends StatelessWidget {
  ApiResponse profile;

  UserProfile(this.profile);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
          alignment: Alignment(0, 0),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage(
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
                    placeholder: NetworkImage(""),
                    image: NetworkImage(profile.user.profilePicUrl),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text("${profile.user.fullName} (${profile.user.username})",
                  style: TextStyle(fontSize: 20, color: Colors.grey[600], fontWeight: FontWeight.w600)),
              SizedBox(
                height: 6,
              ),
              Text(profile.mediaCount == null ? "no stories found" : "${profile.mediaCount} stories"),
            ],
          )),
    );
  }
}
