import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/model/Album_model.dart';

class Song {
  final int songId;
  final String title;
  final String duration;
  final String imageUrl;
  final String mp3Url;
  final String description;
  final String? Lirik;
  final int albumId;
  final String artistName;
  final String artistCountry;
  final String artistImageUrl;
  final String artistBio;
  final String categoryName;
  final String categoryImageUrl;
  final String albumTitle;
  final String albumDuration;
  final int albumReleaseYear;
  final String albumImageUrl;

  Song({
    required this.songId,
    required this.title,
    required this.duration,
    required this.imageUrl,
    required this.mp3Url,
    required this.description,
    required this.Lirik,
    required this.albumId,
    required this.artistName,
    required this.artistCountry,
    required this.artistImageUrl,
    required this.artistBio,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.albumTitle,
    required this.albumDuration,
    required this.albumReleaseYear,
    required this.albumImageUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      songId: json['song_id'],
      title: json['title'],
      duration: json['duration'],
      imageUrl: json['imageUrl'],
      mp3Url: json['file_mp3'],
      description: json['description'],
      Lirik: json['Lirik'],
      albumId: json['album_id'],
      artistName: json['artist_name'],
      artistCountry: json['artist_country'],
      artistImageUrl: json['artist_imageUrl'],
      artistBio: json['artist_bio'],
      categoryName: json['category_name'],
      categoryImageUrl: json['category_imageUrl'],
      albumTitle: json['album_title'],
      albumDuration: json['album_duration'],
      albumReleaseYear: json['album_release_year'],
      albumImageUrl: json['album_imageUrl'],
    );
  }
  static Future<List<Song>> fetchSongs() async {
    final response = await http.get(
      Uri.parse('https://azzalea.pythonanywhere.com/api/songs/'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Song> songs = data.map((songData) {
        return Song.fromJson(songData);
      }).toList();

      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  static Future<List<Song>> fetchSongsFromAlbum(List<Album> albums) async {
    List<Song> allSongs = [];

    try {
      for (Album album in albums) {
        final response = await http.get(
          Uri.parse(
              'https://azzalea.pythonanywhere.com/api/album/${album.albumId}/songs'),
        );

        if (response.statusCode == 200) {
          final dynamic data = json.decode(response.body);

          if (data is List) {
            List<Song> songs = data.map((songData) {
              return Song.fromJson(songData);
            }).toList();

            allSongs.addAll(songs);
          } else {
            throw Exception('Invalid data format: $data');
          }
        } else {
          throw Exception(
              'Failed to load songs for album ID: ${album.albumId}');
        }
      }

      return allSongs;
    } catch (e) {
      throw Exception('Error fetching songs: $e');
    }
  }

  static Future<List<Song>> fetchSongsSearch(String yangdicari) async {
    final response = await http.get(
      Uri.parse(
          'https://azzalea.pythonanywhere.com/api/songs/search/$yangdicari'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Song> songs = data.map((songData) {
        return Song.fromJson(songData);
      }).toList();

      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  static Future<List<Song>> fetch1songsfromalbum(int id) async {
    final response = await http.get(
      Uri.parse('https://azzalea.pythonanywhere.com/api/album/$id/songs'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Song> songs = data.map((songData) {
        return Song.fromJson(songData);
      }).toList();

      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
