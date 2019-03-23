import 'dart:convert';

class ApiResponse {
  bool canReply;
  int id;
  bool canReshare;
  String reelType;
  User user;
  int mediaCount;
  List<Items> items;
  int expiringAt;
  int latestReelMedia;
  String status;

  ApiResponse({this.canReply, this.canReshare, this.reelType, this.user, this.items, this.status});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    canReply = json['can_reply'];
    id = json['id'];
    expiringAt = json['expiring_at'];
    mediaCount = json['media_count'];
    latestReelMedia = json['latest_reel_media'];
    canReshare = json['can_reshare'];
    reelType = json['reel_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['can_reply'] = this.canReply;
    data['can_reshare'] = this.canReshare;
    data['reel_type'] = this.reelType;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }

    data['status'] = this.status;
    return data;
  }
}

class HighLight {
  String id;
  int latestReelMedia;
  Null seen;
  bool canReply;
  bool canReshare;
  String reelType;
  CoverMedia coverMedia;
  User user;
  List<Items> items;
  String title;
  int createdAt;
  int prefetchCount;
  int mediaCount;

  HighLight(
      {this.id,
      this.latestReelMedia,
      this.seen,
      this.canReply,
      this.canReshare,
      this.reelType,
      this.coverMedia,
      this.user,
      this.items,
      this.title,
      this.createdAt,
      this.prefetchCount,
      this.mediaCount});

  HighLight.fromJson(Map<String, dynamic> jsonObj) {
    id = jsonObj['id'];
    latestReelMedia = jsonObj['latest_reel_media'];
    seen = jsonObj['seen'];
    canReply = jsonObj['can_reply'];
    canReshare = jsonObj['can_reshare'];
    reelType = jsonObj['reel_type'];
    coverMedia = jsonObj['cover_media'] != null ? new CoverMedia.fromJson(jsonObj['cover_media']) : null;
    user = jsonObj['user'] != null ? new User.fromJson(jsonObj['user']) : null;
    if (jsonObj['items'] != null) {
      items = new List<Items>();
      jsonObj['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
    title = jsonObj['title'];
    createdAt = jsonObj['created_at'];
    prefetchCount = jsonObj['prefetch_count'];
    mediaCount = jsonObj['media_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latest_reel_media'] = this.latestReelMedia;
    data['seen'] = this.seen;
    data['can_reply'] = this.canReply;
    data['can_reshare'] = this.canReshare;
    data['reel_type'] = this.reelType;
    if (this.coverMedia != null) {
      data['cover_media'] = this.coverMedia.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['prefetch_count'] = this.prefetchCount;
    data['media_count'] = this.mediaCount;
    return data;
  }
}

class Items {
  ImageVersions2 imageVersions2;
  String id;
  List<VideoVersions> videoVersions = [];

  Items({
    this.imageVersions2,
  });

  Items.fromJson(Map<String, dynamic> json) {
    imageVersions2 = json['image_versions2'] != null ? new ImageVersions2.fromJson(json['image_versions2']) : null;

    if (json['video_versions'] != null) {
      videoVersions = new List<VideoVersions>();
      json['video_versions'].forEach((v) {
        videoVersions.add(new VideoVersions.fromJson(v));
      });
    }
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.imageVersions2 != null) {
      data['image_versions2'] = this.imageVersions2.toJson();
    }
    data["id"] = id;

    return data;
  }
}

class ImageVersions2 {
  List<Candidates> candidates;

  ImageVersions2({this.candidates});

  ImageVersions2.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null) {
      candidates = new List<Candidates>();
      json['candidates'].forEach((v) {
        candidates.add(new Candidates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.candidates != null) {
      data['candidates'] = this.candidates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Candidates {
  String url;

  Candidates({this.url});

  Candidates.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['url'] = this.url;
    return data;
  }
}

class VideoVersions {
  String url;
  String id;

  VideoVersions({this.url, this.id});

  VideoVersions.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}

class User {
  String username;
  String fullName;
  bool isPrivate;
  String profilePicUrl;
  String profilePicId;
  bool isVerified;
  bool hasAnonymousProfilePicture;
  String reelAutoArchive;
  bool isUnpublished;
  bool isFavorite;

  User(
      {this.username,
      this.fullName,
      this.isPrivate,
      this.profilePicUrl,
      this.profilePicId,
      this.isVerified,
      this.hasAnonymousProfilePicture,
      this.reelAutoArchive,
      this.isUnpublished,
      this.isFavorite});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['full_name'];
    isPrivate = json['is_private'];
    profilePicUrl = json['profile_pic_url'];
    profilePicId = json['profile_pic_id'];
    isVerified = json['is_verified'];
    hasAnonymousProfilePicture = json['has_anonymous_profile_picture'];
    reelAutoArchive = json['reel_auto_archive'];
    isUnpublished = json['is_unpublished'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['is_private'] = this.isPrivate;
    data['profile_pic_url'] = this.profilePicUrl;
    data['profile_pic_id'] = this.profilePicId;
    data['is_verified'] = this.isVerified;
    data['has_anonymous_profile_picture'] = this.hasAnonymousProfilePicture;
    data['reel_auto_archive'] = this.reelAutoArchive;
    data['is_unpublished'] = this.isUnpublished;
    data['is_favorite'] = this.isFavorite;
    return data;
  }
}

class Location {
  double pk;
  String name;
  String address;
  String city;
  String shortName;
  double lng;
  double lat;
  String externalSource;
  int facebookPlacesId;

  Location(
      {this.pk,
      this.name,
      this.address,
      this.city,
      this.shortName,
      this.lng,
      this.lat,
      this.externalSource,
      this.facebookPlacesId});

  Location.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    shortName = json['short_name'];
    lng = json['lng'];
    lat = json['lat'];
    externalSource = json['external_source'];
    facebookPlacesId = json['facebook_places_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['short_name'] = this.shortName;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['external_source'] = this.externalSource;
    data['facebook_places_id'] = this.facebookPlacesId;
    return data;
  }
}

class HighLightsResponse {
  List<Tray> tray;
  bool showEmptyState;
  String status;

  HighLightsResponse({this.tray, this.showEmptyState, this.status});

  HighLightsResponse.fromJson(Map<String, dynamic> json) {
    if (json['tray'] != null) {
      tray = new List<Tray>();
      json['tray'].forEach((v) {
        tray.add(new Tray.fromJson(v));
      });
    }
    showEmptyState = json['show_empty_state'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tray != null) {
      data['tray'] = this.tray.map((v) => v.toJson()).toList();
    }
    data['show_empty_state'] = this.showEmptyState;
    data['status'] = this.status;
    return data;
  }
}

class SingleHighLightResponse {
  String status;
  HighLight highLight;

  SingleHighLightResponse.fromJson(Map<String, dynamic> jsonObj, String key) {
    status = jsonObj['status'];
//    String dd = jsonObj['reels'].toString();
    if (jsonObj.containsKey("reels")) {
//      Map<String, String> reel = json.decode(jsonObj['reels'].toString());
//      if (reel.containsKey(key)) {
      highLight = HighLight.fromJson(jsonObj['reels'][key]);

//      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['highLight'] = highLight.toJson();

    return data;
  }
}

class Tray {
  String id;
  int latestReelMedia;
  bool seen;
  bool canReply;
  Null canReshare;
  String reelType;
  CoverMedia coverMedia;
  User user;
  int rankedPosition;
  String title;
  int seenRankedPosition;
  int prefetchCount;
  int mediaCount;

  Tray(
      {this.id,
      this.latestReelMedia,
      this.seen,
      this.canReply,
      this.reelType,
      this.coverMedia,
      this.user,
      this.rankedPosition,
      this.title,
      this.seenRankedPosition,
      this.prefetchCount,
      this.mediaCount});

  Tray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latestReelMedia = json['latest_reel_media'];
    seen = json['seen'];
    canReply = json['can_reply'];
    reelType = json['reel_type'];
    coverMedia = json['cover_media'] != null ? new CoverMedia.fromJson(json['cover_media']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latest_reel_media'] = this.latestReelMedia;
    data['seen'] = this.seen;
    data['can_reply'] = this.canReply;
    data['reel_type'] = this.reelType;
    if (this.coverMedia != null) {
      data['cover_media'] = this.coverMedia.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['ranked_position'] = this.rankedPosition;
    data['title'] = this.title;
    data['seen_ranked_position'] = this.seenRankedPosition;
    data['prefetch_count'] = this.prefetchCount;
    data['media_count'] = this.mediaCount;
    return data;
  }
}

class CoverMedia {
  CroppedImageVersion croppedImageVersion;
  String mediaId;

  CoverMedia({this.croppedImageVersion, this.mediaId});

  CoverMedia.fromJson(Map<String, dynamic> json) {
    croppedImageVersion =
        json['cropped_image_version'] != null ? new CroppedImageVersion.fromJson(json['cropped_image_version']) : null;
    mediaId = json['media_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.croppedImageVersion != null) {
      data['cropped_image_version'] = this.croppedImageVersion.toJson();
    }
    data['media_id'] = this.mediaId;
    return data;
  }
}

class CroppedImageVersion {
  int width;
  int height;
  String url;

  CroppedImageVersion({this.width, this.height, this.url});

  CroppedImageVersion.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    return data;
  }
}
