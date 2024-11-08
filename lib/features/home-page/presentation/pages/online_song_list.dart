import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';
import 'package:music_player_v1/features/home-page/domain/entities/song_entity.dart';
import 'package:music_player_v1/features/home-page/presentation/pages/local_song_page.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/config/assets-config/app_vector.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/theme/is_dark_mode.dart';

class OnlineSongList extends StatelessWidget {
  final List<SongEntity> songs;

  const OnlineSongList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: SvgPicture.asset(
          AppVector.spotifyLogo,
          height: 40,
          width: 40,
        ),
        hideBackBtn: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Songs",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode(context) ? Colors.white : Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: (){AppRoutes.push(context,const LocalSongPage());},
                  child: Text(
                    "Local Songs",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode(context) ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // List of Songs
            Expanded(
              child: songs.isEmpty ? const Center(child:  Text("No Songs Found")): ListView.builder(
                itemCount: songs.length, // Placeholder count for songs
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: NetworkImage(songs[index].coverLink),
                            fit: BoxFit.cover,
                            onError: (error, stackTrace) {
                              const Icon(Icons.music_note_outlined);
                            },
                          ),
                        ),

                      ),
                      title: Text(
                        songs[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode(context)
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        songs[index].artist,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppPalette.grayColor,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: isDarkMode(context)
                              ? AppPalette.whiteColor
                              : AppPalette.darkGray,
                        ),
                        onPressed: () {
                          // Add logic to play song
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
