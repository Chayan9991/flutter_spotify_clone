import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/error/failures.dart';
import 'package:music_player_v1/core/error/server_exception.dart';
import 'package:music_player_v1/features/home-page/data/datasources/song_datasource.dart';
import 'package:music_player_v1/features/home-page/data/model/song_model.dart';
import 'package:music_player_v1/features/home-page/domain/entities/song_entity.dart';
import 'package:music_player_v1/features/home-page/domain/repositories/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final SongDataSource songDataSource;
  SongRepositoryImpl(this.songDataSource);

  @override
  Future<Either<Failure, List<SongEntity>>> fetchAllSongs() async {
    try {
      final List<SongModel> songs = await songDataSource.getAllSongs();

      //converting SongModel to SongEntity
      final List<SongEntity> songList = songs.map((song) {
        return SongEntity(
          title: song.title,
          artist: song.artist,
          duration: song.duration,
          releaseDate: song.releaseDate,
          songLink: song.songLink ?? "",
          coverLink: song.coverLink ??""
        );
      }).toList();

      if(songList == null){
        return left(Failure("cant fetch songs"));
      }
      return right(songList);

    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
