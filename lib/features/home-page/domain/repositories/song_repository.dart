import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/error/failures.dart';
import 'package:music_player_v1/features/home-page/domain/entities/song_entity.dart';

abstract class SongRepository{


  Future<Either<Failure, List<SongEntity>>> fetchAllSongs();
}