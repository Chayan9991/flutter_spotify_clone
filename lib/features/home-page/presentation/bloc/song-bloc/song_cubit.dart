import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player_v1/core/error/failures.dart';
import 'package:music_player_v1/core/usecases/usecase.dart';
import 'package:music_player_v1/features/home-page/domain/entities/song_entity.dart';
import 'package:music_player_v1/features/home-page/domain/usecases/get_all_songs.dart';

part 'song_state.dart';

class SongCubit extends Cubit<SongState> {
  final GetAllSongsUseCase getAllSongsUseCase;
  SongCubit(this.getAllSongsUseCase) : super(SongInitial());

  Future<void> fetchTrendingSongs() async {
    emit(SongLoading());

    final result = await getAllSongsUseCase.call(NoParams());

    result.fold((failure) {
      emit(SongFetchError(error: failure));
    }, (songs) {
       emit(SongFetch(songs : songs));
    });
  }
}
