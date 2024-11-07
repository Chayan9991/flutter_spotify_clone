part of 'song_cubit.dart';

@immutable
sealed class SongState {}

final class SongInitial extends SongState {}

final class SongLoading extends SongState{}

final class SongFetch extends SongState{
  final List<SongEntity> songs ;
  SongFetch({required this.songs});
}

final class SongFetchError extends SongState{
  final Failure error;
  SongFetchError({required this.error});
}
