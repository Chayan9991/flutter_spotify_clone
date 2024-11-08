import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';
import 'package:music_player_v1/core/theme/app_palette.dart';
import 'package:music_player_v1/core/theme/is_dark_mode.dart';
import 'package:music_player_v1/core/utils/show_snackbar.dart';
import 'package:music_player_v1/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:music_player_v1/features/home-page/domain/entities/song_entity.dart';
import 'package:music_player_v1/features/home-page/presentation/bloc/song-bloc/song_cubit.dart';
import 'package:music_player_v1/features/home-page/presentation/pages/local_song_page.dart';
import 'package:music_player_v1/features/home-page/presentation/pages/online_song_list.dart';
import 'package:url_launcher/url_launcher.dart'; // Required for GitHub link

import '../../../../core/config/assets-config/app_images.dart';
import '../bloc/theme_cubit.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Function to launch GitHub profile
  void _launchGitHub() async {
    const url = 'https://github.com/Chayan9991';
    final Uri uri = Uri.parse(url); // Convert string URL to Uri

    try {
      // Check if the URL can be launched
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    List<SongEntity> songs = [];

    return Drawer(
      backgroundColor:
      isDark ? const Color(0xFF191414) : AppPalette.lightBackground,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Drawer Header with Profile Info
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String name = "Guest";
                    String email = "guest@gmail.com";

                    if (state is AuthSuccess) {
                      name = state.user.name;
                      email = state.user.email;
                    }
                    return UserAccountsDrawerHeader(
                      accountName: Text(
                        name,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Text(
                        email,
                        style: TextStyle(
                            color: isDark ? Colors.grey : Colors.black54),
                      ),
                      currentAccountPicture: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(AppImages.userLogo),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    );
                  },
                ),

                // Navigation Links
                ListTile(
                  leading: Icon(Icons.home, color: isDark ? Colors.white : Colors.black),
                  title: Text("Home", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                BlocBuilder<SongCubit, SongState>(
                  builder: (context, state) {
                    if (state is SongFetch) {
                      songs = state.songs; // Update the songs list when fetched
                    } else if (state is SongLoading) {
                      print("Song is Loading for drawer");
                    }

                    return ListTile(
                      leading: Icon(
                        Icons.library_music,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      title: Text(
                        "Online Songs",
                        style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      ),
                      onTap: () {
                        if (songs.isNotEmpty) {
                          Navigator.pop(context);
                          AppRoutes.push(context, OnlineSongList(songs: songs));
                        } else {
                          Navigator.pop(context);
                          showSnackBar(context, "Loading songs, please wait");
                        }
                      },
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite, color: isDark ? Colors.white : Colors.black),
                  title: Text("Local Songs", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    AppRoutes.push(context, const LocalSongPage());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: isDark ? Colors.white : Colors.black),
                  title: Text("Settings", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                Divider(color: isDark ? Colors.grey : Colors.black26, thickness: 0.2),

                // Additional Options
                ListTile(
                  leading: Icon(isDark ? Icons.nightlight_round : Icons.light_mode_rounded, color: isDark ? Colors.white : Colors.black),
                  title: Text(isDark ? "Dark Mode" : "Light Mode", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                  trailing: Switch(
                    activeColor: AppPalette.primary,
                    value: isDark,
                    onChanged: (val) {
                      context.read<ThemeCubit>().updateTheme(isDark ? ThemeMode.light : ThemeMode.dark);
                    },
                  ),
                ),

                // Logout Option
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return ListTile(
                      leading: state is AuthLoading
                          ? const CircularProgressIndicator(color: AppPalette.primary)
                          : const Icon(Icons.logout, color: AppPalette.primary),
                      title: state is AuthLoading
                          ? const Text("Logging out...", style: TextStyle(color: AppPalette.primary))
                          : const Text("Logout", style: TextStyle(color: AppPalette.primary)),
                      onTap: () async {
                        if (state is AuthLoading) return; // Disable button if already loading

                        // Show confirmation dialog
                        bool? confirmed = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Logout"),
                              content: const Text("Are you sure you want to log out?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); // User pressed cancel
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // User pressed confirm
                                  },
                                  child: const Text("Confirm"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmed == true) {
                          context.read<AuthCubit>().onAuthLogout(context);
                        }
                      },
                    );
                  },
                ),
                Divider(color: isDark ? Colors.grey : Colors.black26, thickness: 0.2),
              ],
            ),
          ),
          // Footer Section with Name, Copyright, and GitHub Link
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(color: isDark ? Colors.grey : Colors.black26, thickness: 0.5),
                Text(
                  "© 2024 Chayan Barman",
                  style: TextStyle(fontSize: 12, color: isDark ? Colors.white54 : Colors.black54),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: _launchGitHub,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.link, size: 16, color: AppPalette.primary),
                      SizedBox(width: 5),
                      Text(
                        "GitHub",
                        style: TextStyle(
                          color: AppPalette.primary,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
