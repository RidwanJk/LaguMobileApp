import 'package:flutter/material.dart';
import 'package:myapp/model/Album_model.dart';
import 'package:myapp/model/Artist_model.dart';
import 'package:myapp/model/song_model.dart';
import 'package:myapp/views/album_detail_page.dart';
import 'package:myapp/views/artist_detail_page.dart';
import 'package:myapp/views/song_details_page.dart';
import 'package:myapp/widgets/custom_widged.dart';

class libview extends StatefulWidget {
  const libview({Key? key}) : super(key: key);

  @override
  State<libview> createState() => _libviewState();
}

class _libviewState extends State<libview> {
  List<Song> songs = [];
  List<Album> albums = [];
  List<Artist> artists = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    fetchSongs();
    fetchAlbums();
    fetchArtists();
  }

  fetchSongs() async {
    try {
      setState(() {
        _loading = true;
      });
      List<Song> fetchedSongs = await Song.fetchSongs();
      setState(() {
        songs = fetchedSongs;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error fetching Song: $e');
    }
  }

  fetchAlbums() async {
    try {
      setState(() {
        _loading = true;
      });
      List<Album> fetchedAlbums = await Album.fetchAlbumsOnly();
      setState(() {
        albums = fetchedAlbums;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error fetching Albums: $e');
    }
  }

  fetchArtists() async {
    try {
      setState(() {
        _loading = true;
      });
      List<Artist> fetchedArtists = await Artist.fetchArtist();
      setState(() {
        artists = fetchedArtists;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Error fetching Artists: $e');
    }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 5, 49),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 5, 49),
          leading: Container(
            margin: EdgeInsets.all(10),
            child: const Avatar(
              imageUrl:
                  "https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg",
            ),
          ),
          title: const Text(
            'Your Library',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: TabBar(
              tabs: [
                Tab(text: "Song"),
                Tab(text: "Albums"),
                Tab(text: "Artists"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Songs Tab
            _loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              songs[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            songs[index].title,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          final song = songs[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SongDetailsPage(song: song)),
                          );
                        },
                      );
                    },
                  ),
            _loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              albums[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            albums[index].title,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          final album = albums[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AlbumDetailPage(album: album),
                            ),
                          );
                        },
                      );
                    },
                  ),
            _loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: artists.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              artists[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            artists[index].name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        onTap: () {
                          final artist = artists[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  artistDetail(artist: artist),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
