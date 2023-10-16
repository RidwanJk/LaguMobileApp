class Playlist {
  final String name;
  final String description;
  final String owner;
  final int tracks;
  final String imageUrl;

  Playlist({
    required this.name,
    required this.description,
    required this.owner,
    required this.tracks,
    required this.imageUrl,
  });
}

final List<Playlist> PlayListModel = [
  Playlist(
    name: "JpunSongByBihi",
    description: "WEEEBS",
    owner: "Ridwan Jauhar Kafabihi",
    tracks: 99,
    imageUrl:
        "https://i.scdn.co/image/ab67616d0000b27303808f76fad28ce8523f5ac6",
  ),
  Playlist(
    name: "Sad Vibes",
    description: "Cry",
    owner: "Gabbie",
    tracks: 182,
    imageUrl:
        "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbebc033d168a507247cac3248",
  ),
  Playlist(
    name: "Liked Songs",
    description: "-",
    owner: "Ridwan Jauhar Kafabihi",
    tracks: 415,
    imageUrl:
        "https://i.scdn.co/image/ab67706c0000da8470d229cb865e8d81cdce0889",
  ),
  Playlist(
    name: "Sigma Male Songs 2023 🗿",
    description: "If they make you an option make them your history",
    owner: "WIRED AU",
    tracks: 64,
    imageUrl:
        "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000bebbadfd7c09ccbe520d93559ecf",
  ),
];
