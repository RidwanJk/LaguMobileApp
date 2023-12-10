import 'dart:convert';
import 'package:http/http.dart' as http;

class Artist {
  final int artist_id;
  final String name;
  final String country;
  final String bio;
  final String imageUrl;

  Artist({
    required this.artist_id,
    required this.name,
    required this.country,
    required this.bio,
    required this.imageUrl,
  });
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artist_id: json['artist_id'],
      name: json['name'],
      country: json['country'],
      imageUrl: json['imageUrl'],
      bio: json['bio'],
    );
  }
  static Future<List<Artist>> fetchArtist() async {
    final response = await http
        .get(Uri.parse('https://azzalea.pythonanywhere.com/api/artists'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      List<Artist> artists = data.map((artistData) {
        return Artist.fromJson(artistData);
      }).toList();

      return artists;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
