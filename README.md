# music_player_v1

This project is a Spotify clone application developed using Flutter and follows the principles of
Clean Architecture.

## Overview

The **music_player_v1** app is designed to provide a user interface similar to Spotify, allowing
users to listen to music. The project aims to implement essential features such as authentication,
state management, and a media player that can handle both local and online songs.

## Getting Started

### Technologies Used

- **Flutter**: For cross-platform mobile app development.
- **BLoC & Cubit**: For state management.
- **GetIt**: For dependency injection.
- **Supabase**: For backend services, including authentication and storage.

### Project Goals

Initially, the app was built using Firebase for authentication, database management, and storage.
However, I later transitioned to Supabase due to its free storage service, which is essential for
this project. The project now includes the following features:

- **User Interface**: Development of a Spotify-like UI.
- **Theme Support**: Implementation of light and dark themes.
- **Authentication**: Users can register and log in.
- **Architecture**: Clean Architecture is used for better project management.
- **Song Management**: Users can load local songs and access songs stored in a Supabase bucket.

## Features

- **Local Song Playback**: Users can play songs stored on their devices.
- **Online Song Streaming**: Users can stream songs stored in the Supabase storage bucket.
- **User Management**: Authentication and user management are handled through Supabase.

## Data Management

In the Supabase storage bucket, song details such as title, artist name, and duration are stored in
a dedicated database table. This allows the app to fetch and display song information alongside the
actual audio files.

### Song Cover Management

For songs with embedded covers, it is still recommended to separately add cover images to the
Supabase storage for better management and display in the app.

## Conclusion

This project combines various technologies to create a functional music player app that leverages
both local and online storage capabilities. The switch from Firebase to Supabase was made to take
advantage of the free storage features offered by Supabase.

### Future Enhancements

Potential enhancements include:

- Implementation of Hive for local caching of songs to reduce database requests.
- Adding features to allow users to create playlists and favorite songs.

Feel free to explore the project and provide feedback or suggestions for further improvements!
