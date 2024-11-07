class SongEntity {
  final String title;
  final String artist;
  final String duration;
  final DateTime releaseDate;
  final String songLink;
  final String coverLink;

  SongEntity(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.songLink,
      required this.coverLink});

  @override
  String toString() {
    return 'SongEntity{title: $title, artist: $artist, duration: $duration, releaseDate: $releaseDate, songLink: $songLink}';
  }
}
