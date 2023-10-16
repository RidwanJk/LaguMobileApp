import 'package:spotify/spotify.dart';

class Album {
  final String id;
  final String name;
  final String href;
  final String type;
  final String uri;
  final String albumType;
  final List<String> artists;
  final List<String> availableMarkets;
  final List<String> images;
  final String releaseDate;
  final String releaseDatePrecision;

  Album({
    required this.id,
    required this.name,
    required this.href,
    required this.type,
    required this.uri,
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.images,
    required this.releaseDate,
    required this.releaseDatePrecision,
  });
}

final List<Album> AlbumModel = [];
