import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_player_v1/core/routes/app_routes.dart';
import 'package:music_player_v1/features/home-page/presentation/Widgets/drawer.dart';
import 'package:music_player_v1/features/home-page/presentation/pages/online_song_list.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/config/assets-config/app_images.dart';
import '../../../../core/config/assets-config/app_vector.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/theme/is_dark_mode.dart';
import '../bloc/song-bloc/song_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    final songCubit = context.read<SongCubit>();
    songCubit.fetchTrendingSongs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _homeTopCard(),
            const SizedBox(height: 20),
            _tabBar(),
            _tabContent(),
            _playList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: Container(
        height: 188,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVector.homeTopCard),
            ),
            Align(
              alignment: const Alignment(.5, 0),
              child: Image.asset(AppImages.homeArtist2),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(AppImages.homeArtist1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    const tabList = ["Trending", "Videos", "Artists", "Podcasts"];
    return TabBar(
      controller: _tabController,
      tabs: tabList.map((tabTitle) => Tab(text: tabTitle)).toList(),
      labelColor: isDarkMode(context) ? Colors.white : Colors.black,
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      indicatorColor: AppPalette.primary,
      dividerColor: Colors.transparent,
    );
  }

  Widget _tabContent() {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TabBarView(
          controller: _tabController,
          children: [
            _trendingContent(),
            const Center(child: Text("Videos Content")),
            const Center(child: Text("Artists Content")),
            const Center(child: Text("Podcasts Content")),
          ],
        ),
      ),
    );
  }

  Widget _trendingContent() {
    return BlocBuilder<SongCubit, SongState>(
      builder: (context, state) {
        if (state is SongLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SongFetch) {
          final songs = state.songs;
          return ListView.builder(
            itemCount: songs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                // Optional padding for spacing
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 130, // Set a width
                          height: 160, // Set a height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            // Optional rounded corners
                            image: DecorationImage(
                              image: NetworkImage(songs[index].coverLink),
                              fit: BoxFit.cover,
                              onError: (error, stackTrace) {
                                print('Failed to load image: $error');
                              },
                            ),
                          ),
                          child: songs[index].coverLink.isNotEmpty
                              ? null // If image URL exists, show image
                              : const Center(
                                  child: Icon(Icons
                                      .music_note)), // Placeholder icon if no URL
                        ),
                        Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: isDarkMode(context)
                                      ? AppPalette.darkGray.withOpacity(.9)
                                      : const Color(0xffE6E6E6),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow),
                                color: isDarkMode(context)
                                    ? const Color(0xffE6E6E6)
                                    : AppPalette.darkGray,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      songs[index].title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is SongFetchError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const Center(child: Text('No songs found.'));
        }
      },
    );
  }

  Widget _playList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SongCubit, SongState>(
            builder: (context, state) {
              if (state is SongLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SongFetch) {
                final songs = state.songs;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Playlist title and See More button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Playlist",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: AppPalette.primary),
                        ),
                        GestureDetector(
                          onTap: () {
                            AppRoutes.push(
                              context,
                              OnlineSongList(
                                  songs: songs), // Pass songs to AllSongList
                            );
                          },
                          child: const Text(
                            "All Songs",
                            style: TextStyle(
                                color: AppPalette.primary, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Space between title and playlist

                    // Display only 2 playlist items
                    ListView.builder(
                      itemCount: songs.length > 2 ? 2 : songs.length,
                      shrinkWrap: true,
                      // Ensures ListView only takes as much space as needed
                      physics: const NeverScrollableScrollPhysics(),
                      // Disable ListView scrolling
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Play Icon and Song Details
                              Row(
                                children: [
                                  const Icon(Icons.play_arrow,
                                      color: AppPalette.grayColor),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        songs[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        songs[index].artist,
                                        style: const TextStyle(
                                            color: AppPalette.grayColor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    songs[index].duration,
                                    style: const TextStyle(
                                        color: AppPalette.grayColor),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.favorite_border,
                                      color: AppPalette.grayColor),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("No songs available"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
