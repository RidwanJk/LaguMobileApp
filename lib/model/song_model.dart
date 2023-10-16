class Song {
  final int rank;
  final String title;
  final String artist;
  final String album;
  final String year;
  final String ImageUrl;

  Song({
    required this.rank,
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.ImageUrl,
  });
}

class Grid {
  final String title;
  final String ImageUrl;

  Grid({
    required this.title,
    required this.ImageUrl,
  });
}

final List<Song> songs = [
  Song(
    rank: 1,
    title: "Bohemian Rhapsody",
    artist: "Queen",
    album: "Killer Queen",
    year: "1975",
    ImageUrl:
        "https://m.media-amazon.com/images/M/MV5BMTA2NDc3Njg5NDVeQTJeQWpwZ15BbWU4MDc1NDcxNTUz._V1_.jpg",
  ),
  Song(
    rank: 2,
    title: "Mockingbird",
    artist: "Eminem",
    album: "Encore",
    year: "2004",
    ImageUrl:
        "https://i.scdn.co/image/ab67616d00001e0227f2230da1986261f618172e",
  ),
  Song(
    rank: 3,
    title: "Bohemian Rhapsody",
    artist: "Queen",
    album: "Killer Queen",
    year: "1975",
    ImageUrl:
        "https://m.media-amazon.com/images/M/MV5BMTA2NDc3Njg5NDVeQTJeQWpwZ15BbWU4MDc1NDcxNTUz._V1_.jpg",
  ),
  Song(
    rank: 4,
    title: "Bohemian Rhapsody",
    artist: "Queen",
    album: "Killer Queen",
    year: "1975",
    ImageUrl:
        "https://m.media-amazon.com/images/M/MV5BMTA2NDc3Njg5NDVeQTJeQWpwZ15BbWU4MDc1NDcxNTUz._V1_.jpg",
  ),
  Song(
    rank: 5,
    title: "Bohemian Rhapsody",
    artist: "Queen",
    album: "Killer Queen",
    year: "1975",
    ImageUrl:
        "https://m.media-amazon.com/images/M/MV5BMTA2NDc3Njg5NDVeQTJeQWpwZ15BbWU4MDc1NDcxNTUz._V1_.jpg",
  ),
  Song(
    rank: 6,
    title: "Bohemian Rhapsody",
    artist: "Queen",
    album: "Killer Queen",
    year: "1975",
    ImageUrl:
        "https://m.media-amazon.com/images/M/MV5BMTA2NDc3Njg5NDVeQTJeQWpwZ15BbWU4MDc1NDcxNTUz._V1_.jpg",
  ),
  Song(
    rank: 7,
    title: "Bohemian Rhapsody",
    artist: "Queen",
    album: "Killer Queen",
    year: "1975",
    ImageUrl:
        "https://m.media-amazon.com/images/M/MV5BMTA2NDc3Njg5NDVeQTJeQWpwZ15BbWU4MDc1NDcxNTUz._V1_.jpg",
  ),
];
