import 'package:music_player_v1/features/home-page/data/model/song_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SongDataSource{
  Future<List<SongModel>> getAllSongs();

}

class SongDataSourceImpl extends SongDataSource{

  final SupabaseClient supabaseClient;
  SongDataSourceImpl(this.supabaseClient);

  @override
  Future<List<SongModel>> getAllSongs() async{

    final response = await supabaseClient.from('songs').select();
    if (response.isEmpty) {
      print("Error fetching songs:");
    }
    // Parse data into a list of Song objects
    return (response as List)
        .map((song) => SongModel.fromJson(song))
        .toList();
  }

}