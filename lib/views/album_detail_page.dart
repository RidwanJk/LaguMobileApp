import 'package:flutter/material.dart';
import 'package:myapp/model/Album_model.dart';
import 'package:myapp/model/song_model.dart';
import 'package:myapp/views/song_details_page.dart';

class AlbumDetailPage extends StatefulWidget {
  final Album album;
  AlbumDetailPage({
    required this.album,
  });

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  List<Song> songs = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final albumid = widget.album.albumId;
    fetchSongs(albumid);
  }

  fetchSongs(int id) async {
    try {
      setState(() {
        _loading = true;
      });
      List<Song> fetchedSongs = await Song.fetch1songsfromalbum(id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 5, 49),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "${widget.album.title}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              titlePadding:
                  EdgeInsets.only(bottom: 16.0), // Adjust the value as needed
              background: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ], // Transparent to black
                  ).createShader(bounds);
                },
                blendMode: BlendMode.multiply,
                child: Image.network(
                  widget.album.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (songs.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final Song song = songs[index];
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    leading: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    title: Row(
                      children: [
                        Image.network(
                          song.imageUrl,
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          song.title, // Use song title from your model
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongDetailsPage(song: song),
                        ),
                      );
                    },
                  );
                }
              },
              childCount: songs.length > 0 ? songs.length : 1,
            ),
          ),
        ],
      ),
    );
  }
}
