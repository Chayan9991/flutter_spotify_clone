import 'package:dartz/dartz.dart';
import 'package:music_player_v1/core/error/failures.dart';
import 'package:music_player_v1/core/usecases/usecase.dart';
import 'package:music_player_v1/features/home-page/domain/entities/song_entity.dart';
import 'package:music_player_v1/features/home-page/domain/repositories/song_repository.dart';

class GetAllSongsUseCase extends UseCase<List<SongEntity>, NoParams>{

  final SongRepository songRepository;
  GetAllSongsUseCase(this.songRepository);

  @override
  Future<Either<Failure, List<SongEntity>>> call(NoParams params) async{
    return await songRepository.fetchAllSongs();
  }

}