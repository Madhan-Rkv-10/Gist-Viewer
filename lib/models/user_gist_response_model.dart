class GistList {
  List<Gist>? allGist;
  GistList({this.allGist});
  factory GistList.fromJson(List<dynamic> json) {
    final List data = List.from(json);
    final List<Gist> all = data
        .map(
          (e) => Gist.fromJson(e),
        )
        .toList();
    return GistList(allGist: all);
  }
}

class Gist {
  String? url;
  String? forksUrl;
  String? commitsUrl;
  String? id;
  String? nodeId;
  String? gitPullUrl;
  String? gitPushUrl;
  String? htmlUrl;
  Map<String, FileDetails>? files;
  bool? public;
  String? createdAt;
  String? updatedAt;
  String? description;
  int? comments;
  User? owner;
  bool? truncated;

  Gist({
    this.url,
    this.forksUrl,
    this.commitsUrl,
    this.id,
    this.nodeId,
    this.gitPullUrl,
    this.gitPushUrl,
    this.htmlUrl,
    this.files,
    this.public,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.comments,
    this.owner,
    this.truncated,
  });

  factory Gist.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> filesJson = json['files'];
    Map<String, FileDetails> files = {};
    filesJson.forEach((key, value) {
      files[key] = FileDetails.fromJson(value);
    });
    return Gist(
      url: json['url'],
      forksUrl: json['forks_url'],
      commitsUrl: json['commits_url'],
      id: json['id'],
      nodeId: json['node_id'],
      gitPullUrl: json['git_pull_url'],
      gitPushUrl: json['git_push_url'],
      htmlUrl: json['html_url'],
      files: files,
      public: json['public'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      description: json['description'],
      comments: json['comments'],
      owner: json['owner'] != null ? User.fromJson(json['owner']) : null,
      truncated: json['truncated'],
    );
  }
}

class FileDetails {
  String? filename;
  String? type;
  String? language;
  String? rawUrl;
  int? size;

  FileDetails({
    required this.filename,
    required this.type,
    required this.language,
    required this.rawUrl,
    required this.size,
  });

  factory FileDetails.fromJson(Map<String, dynamic> json) {
    return FileDetails(
      filename: json['filename'],
      type: json['type'],
      language: json['language'],
      rawUrl: json['raw_url'],
      size: json['size'],
    );
  }
}

class User {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;

  User({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
      htmlUrl: json['html_url'],
      followersUrl: json['followers_url'],
      followingUrl: json['following_url'],
      gistsUrl: json['gists_url'],
      starredUrl: json['starred_url'],
      subscriptionsUrl: json['subscriptions_url'],
      organizationsUrl: json['organizations_url'],
      reposUrl: json['repos_url'],
      eventsUrl: json['events_url'],
      receivedEventsUrl: json['received_events_url'],
      type: json['type'],
      siteAdmin: json['site_admin'],
    );
  }
}
