import 'package:flutter/material.dart';
import 'package:myapp/views/song_details_page.dart';
import 'package:myapp/model/song_model.dart';

class Avatar extends StatelessWidget {
  final String imageUrl; // Pass the image URL as a parameter

  const Avatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25, // Change this radius for the width of the circular border
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius:
            23, // This radius is the radius of the picture in the circle avatar itself.
        backgroundImage: NetworkImage(imageUrl), // Use the provided image URL
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  BigCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage("assets/images/bgcolors.jpg"),
                fit: BoxFit.cover,
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: 150,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.play_arrow),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SongCard extends StatefulWidget {
  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  List<Song> songs = [];

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  fetchSongs() async {
    try {
      List<Song> fetchedSongs = await Song.fetchSongs();
      setState(() {
        songs = fetchedSongs;
      });
    } catch (e) {
      print('Error fetching songs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      itemBuilder: (BuildContext context, int index) {
        return SongItemCard(
          song: songs[index],
        );
      },
    );
  }
}

class SongItemCard extends StatelessWidget {
  final Song song;

  SongItemCard({required this.song});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SongDetailsPage(song: song),
        //   ),
        // );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(song.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}
