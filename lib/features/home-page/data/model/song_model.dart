class SongModel {
  String title;
  String artist;
  String duration;
  DateTime releaseDate;
  String? songLink;
  String? coverLink;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    this.songLink,
    this.coverLink
  });

  SongModel.fromJson(Map<String, dynamic> data)
      : title = data['title'] ?? '',
        artist = data['artists'] ?? '',
        duration = data['duration'] ?? '',
        releaseDate = DateTime.parse(data['release_date'] ?? ''),
        songLink = data['song_link'],
        coverLink = data['cover_link']
  ;
}
