class ApiResponse {

  bool canReply;
  bool canReshare;
  String reelType;
  User user;
  List<Items> items;
  double prefetchCount;
  bool hasBestiesMedia;
  int mediaCount;
  String status;

  ApiResponse(
      {
      this.canReply,
      this.canReshare,
      this.reelType,
      this.user,
      this.items,
      this.prefetchCount,
      this.hasBestiesMedia,
      this.mediaCount,
      this.status});

  ApiResponse.fromJson(Map<String, dynamic> json) {

    canReply = json['can_reply'];
    canReshare = json['can_reshare'];
    reelType = json['reel_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    prefetchCount = json['prefetch_count'];
    hasBestiesMedia = json['has_besties_media'];
    mediaCount = json['media_count'];
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
    data['prefetch_count'] = this.prefetchCount;
    data['has_besties_media'] = this.hasBestiesMedia;
    data['media_count'] = this.mediaCount;
    data['status'] = this.status;
    return data;
  }
}

class FriendshipStatus {
  bool following;
  bool followedBy;
  bool blocking;
  bool muting;
  bool isPrivate;
  bool incomingRequest;
  bool outgoingRequest;
  bool isBestie;

  FriendshipStatus(
      {this.following,
      this.followedBy,
      this.blocking,
      this.muting,
      this.isPrivate,
      this.incomingRequest,
      this.outgoingRequest,
      this.isBestie});

  FriendshipStatus.fromJson(Map<String, dynamic> json) {
    following = json['following'];
    followedBy = json['followed_by'];
    blocking = json['blocking'];
    muting = json['muting'];
    isPrivate = json['is_private'];
    incomingRequest = json['incoming_request'];
    outgoingRequest = json['outgoing_request'];
    isBestie = json['is_bestie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['following'] = this.following;
    data['followed_by'] = this.followedBy;
    data['blocking'] = this.blocking;
    data['muting'] = this.muting;
    data['is_private'] = this.isPrivate;
    data['incoming_request'] = this.incomingRequest;
    data['outgoing_request'] = this.outgoingRequest;
    data['is_bestie'] = this.isBestie;
    return data;
  }
}

class Items {
  ImageVersions2 imageVersions2;

  List<VideoVersions> videoVersions;

  List<StoryLocations> storyLocations;

  Items({
    this.imageVersions2,
    this.storyLocations,
  });

  Items.fromJson(Map<String, dynamic> json) {
    imageVersions2 = json['image_versions2'] != null
        ? new ImageVersions2.fromJson(json['image_versions2'])
        : null;

    if (json['story_locations'] != null) {
      storyLocations = new List<StoryLocations>();
      json['story_locations'].forEach((v) {
        storyLocations.add(new StoryLocations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.imageVersions2 != null) {
      data['image_versions2'] = this.imageVersions2.toJson();
    }

    if (this.storyLocations != null) {
      data['story_locations'] =
          this.storyLocations.map((v) => v.toJson()).toList();
    }
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
  int width;
  int height;
  String url;

  Candidates({this.width, this.height, this.url});

  Candidates.fromJson(Map<String, dynamic> json) {
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

class VideoVersions {
  int type;
  int width;
  int height;
  String url;
  String id;

  VideoVersions({this.type, this.width, this.height, this.url, this.id});

  VideoVersions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}

class User {
  int pk;
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
      {this.pk,
      this.username,
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
    pk = json['pk'];
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
    data['pk'] = this.pk;
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

class StoryLocations {
  double x;
  double y;
  int z;
  double width;
  double height;
  int rotation;
  int isPinned;
  int isHidden;
  Location location;

  StoryLocations(
      {this.x,
      this.y,
      this.z,
      this.width,
      this.height,
      this.rotation,
      this.isPinned,
      this.isHidden,
      this.location});

  StoryLocations.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    z = json['z'];
    width = json['width'];
    height = json['height'];
    rotation = json['rotation'];
    isPinned = json['is_pinned'];
    isHidden = json['is_hidden'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['z'] = this.z;
    data['width'] = this.width;
    data['height'] = this.height;
    data['rotation'] = this.rotation;
    data['is_pinned'] = this.isPinned;
    data['is_hidden'] = this.isHidden;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
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
    coverMedia = json['cover_media'] != null
        ? new CoverMedia.fromJson(json['cover_media'])
        : null;
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
    croppedImageVersion = json['cropped_image_version'] != null
        ? new CroppedImageVersion.fromJson(json['cropped_image_version'])
        : null;
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
