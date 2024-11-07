import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/config/assets-config/app_vector.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/theme/is_dark_mode.dart';

class LocalSongPage extends StatelessWidget {
  const LocalSongPage({super.key});

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
            Text(
              "Local Music",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Import Music Button
            ElevatedButton.icon(
              onPressed: () {
                // Add logic to import music from storage
              },
              icon: Icon(Icons.file_upload, color: AppPalette.primary),
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Import Music from Storage",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode(context)
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: isDarkMode(context)
                    ? AppPalette.darkGray.withOpacity(0.8)
                    : const Color(0xFFF2F2F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // List of Songs
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Placeholder count for songs
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.music_note,
                          color: AppPalette.grayColor, size: 40),
                      title: Text(
                        "Song Title $index",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode(context)
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        "Artist $index",
                        style: TextStyle(
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
