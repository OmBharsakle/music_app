
class ApiMusicModel {
  dynamic success;
  late Data data;

  ApiMusicModel({required this.success, required this.data});
  factory ApiMusicModel.fromJson(Map m1)
  {
    return ApiMusicModel(success: m1['success'], data: Data.fromJson(m1['data']));
  }
}

class Data {
  dynamic total, start;
  late List<Results> results;

  Data({required this.total,required this.start,required this.results});
  factory Data.fromJson(Map m1)
  {
    return Data(total: m1['total'], start: m1['start'], results: (m1['results'] as List).map((e) => Results.fromJson(e),).toList());
  }
}

class Results {
  String? id, name, type, year, label, language, copyright;
  bool hasLyrics;
  late Artists artists;
  late List<Image> image;
  late List<DownloadUrl> downloadUrl;

  Results(
      {required this.id,
      required this.name,
      required this.type,
      required this.year,
      required this.label,
      required this.language,
      required this.copyright,
      required this.hasLyrics,
      required this.artists,
      required this.image,
      required this.downloadUrl});
  factory Results.fromJson(Map m1)
  {
    return Results(
        id: m1['id'],
        name: m1['name'],
        type: m1['type'],
        year: m1['year'],
        label: m1['label'],
        language: m1['language'],
        copyright: m1['copyright'],
        hasLyrics: m1['hasLyrics'],
        artists: Artists.fromJson(m1['artists']),
        image: (m1['image'] as List).map((e) => Image.fromJson(e),).toList(),
        downloadUrl: (m1['downloadUrl'] as List).map((e) => DownloadUrl.formJson(e),).toList());
  }
}


class Image {
  String? url;

  Image({required this.url});

  factory Image.fromJson(Map m1)
  {
    return Image(url: m1['url']);
  }
}

class DownloadUrl {
  String? url;

  DownloadUrl({required this.url});
  factory DownloadUrl.formJson(Map m1)
  {
    return DownloadUrl(url: m1['url']);
  }
}
class Artists {
  late List<Primary> primary;

  Artists(this.primary);
  factory Artists.fromJson(Map m1)
  {
    return Artists((m1["primary"] as List).map((e) => Primary.fromJson(e),).toList());
  }
}

class Primary{
  String? id,name,role;
  late List<PrimaryImage> image;

  Primary({required this.id,required this.name,required this.role,required this.image});
  factory Primary.fromJson(Map m1)
  {
    return Primary(id: m1["id"], name: m1["name"], role: m1["role"], image: (m1["image"] as List).map((e) => PrimaryImage.fromJson(e),).toList());
  }
}

class PrimaryImage{
  String? url;

  PrimaryImage({required this.url});
  factory PrimaryImage.fromJson(Map m1)
  {
    return PrimaryImage(url: m1['url']);
  }
}