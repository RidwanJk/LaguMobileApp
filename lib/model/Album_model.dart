import 'dart:convert';
import 'package:http/http.dart' as http;

class Album {
  final int albumId;
  final String title;
  final String duration;
  final int releaseYear;
  final String imageUrl;

  Album({
    required this.albumId,
    required this.title,
    required this.duration,
    required this.releaseYear,
    required this.imageUrl,
  });
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumId: json['album_id'],
      title: json['title'],
      duration: json['duration'],
      releaseYear: json['release_year'],
      imageUrl: json['imageUrl'],
    );
  }
  static Future<List<Album>> fetchAlbums(dynamic id) async {
    final response = await http.get(Uri.parse(
        'https://azzalea.pythonanywhere.com/api/category/$id/albums/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Album> albums = data.map((albumData) {
        return Album.fromJson(albumData);
      }).toList();

      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }

  static Future<List<Album>> fetchAlbumsOnly() async {
    final response = await http
        .get(Uri.parse('https://azzalea.pythonanywhere.com/api/albums'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Album> albums = data.map((albumData) {
        return Album.fromJson(albumData);
      }).toList();

      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
