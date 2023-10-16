import 'package:flutter/material.dart';
import 'package:myapp/model/playlist_model.dart';
import 'package:myapp/views/browse_detail.dart';
import 'package:myapp/views/playlist_detail_page.dart';
import 'package:myapp/views/song_details_page.dart';
import 'package:myapp/model/song_model.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:convert';

class PlaylistGrid extends StatelessWidget {
  final List<Playlist> playlists;

  PlaylistGrid({required this.playlists});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Number of columns
      childAspectRatio: 2, // Aspect ratio for the items
      physics: NeverScrollableScrollPhysics(), // Disable scrolling
      shrinkWrap: true, // Allow the grid to adapt to its content size
      children: playlists
          .map((playlist) => PlaylistButton(playlist: playlist))
          .toList(),
    );
  }
}

class PlaylistButton extends StatelessWidget {
  final Playlist playlist;

  PlaylistButton({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayListDetail(PLModel: playlist)),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(31, 58, 58, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
            margin: EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                playlist.imageUrl,
                fit: BoxFit.fill, // Memastikan gambar sesuai dalam kotak
              ),
            ),
          ),
          Expanded(
            child: Text(
              playlist.name,
              overflow:
                  TextOverflow.ellipsis, // Truncate the text with an ellipsis
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildTombol(String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.013),
      side: const BorderSide(
        color: Color.fromRGBO(255, 255, 255, 0.3),
        width: 2.0,
      ),
    ),
    onPressed: () {},
    child: SizedBox(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontFamily: 'Inter-Bold'),
        ),
      ),
    ),
  );
}

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

class SongListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      itemBuilder: (BuildContext context, int index) {
        final song = songs[index];
        return Column(
          children: [
            SongCard(song: song),
            Desc(song: song),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        // Adjust the height of the separator as needed
        return SizedBox(width: 0); // You can change 10 to your desired spacing
      },
    );
  }
}

class SongCard extends StatelessWidget {
  final Song song;

  SongCard({required this.song});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongDetailsPage(song: song),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(song.ImageUrl), // Use the provided image URL
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class Desc extends StatelessWidget {
  final Song song;

  Desc({required this.song});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5, top: 5),
              child: Text(
                song.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, right: 5, top: 5),
              child: Text(
                '${song.artist} - ${song.album} (${song.year})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // Background color when not focused
        hintText: "Search Song, Lyrics or Artist",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(
                255, 89, 89, 89), // Background color when focused
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class GridViewSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 1.75,
      ),
      itemCount: 20, // Number of items in the grid
      itemBuilder: (context, index) {
        // Replace this with your item widget
        final List<Grid> gridlist = [
          Grid(
            title: "Podcast",
            ImageUrl: "https://picsum.photos/200?seed=1",
          ),
          Grid(
            title: "Live Event",
            ImageUrl: "https://picsum.photos/200?seed=2",
          ),
          Grid(
            title: "Made For You",
            ImageUrl: "https://picsum.photos/200?seed=765",
          ),
          Grid(
            title: "New Releases",
            ImageUrl: "https://picsum.photos/200?seed=909",
          ),
          Grid(
            title: "Pop",
            ImageUrl: "https://picsum.photos/200?seed=12112",
          ),
          Grid(
            title: "Rock",
            ImageUrl: "https://picsum.photos/200?seed=2323",
          ),
          Grid(
            title: "Hip Hop",
            ImageUrl: "https://picsum.photos/200?seed=123456",
          ),
          Grid(
            title: "Classical",
            ImageUrl: "https://picsum.photos/200?seed=1211",
          ),
          Grid(
            title: "Country",
            ImageUrl: "https://picsum.photos/200?seed=44",
          ),
          Grid(
            title: "Jazz",
            ImageUrl: "https://picsum.photos/200?seed=33",
          ),
          Grid(
            title: "Blues",
            ImageUrl: "https://picsum.photos/200?seed=22",
          ),
          Grid(
            title: "Electronic",
            ImageUrl: "https://picsum.photos/200?seed=51",
          ),
          Grid(
            title: "Reggae",
            ImageUrl: "https://picsum.photos/200?seed=23421",
          ),
          Grid(
            title: "R&B",
            ImageUrl: "https://picsum.photos/200?seed=2312",
          ),
          Grid(
            title: "Metal",
            ImageUrl: "https://picsum.photos/200?seed=3",
          ),
          Grid(
            title: "Alternative",
            ImageUrl: "https://picsum.photos/200?seed=2134",
          ),
          Grid(
            title: "Folk",
            ImageUrl: "https://picsum.photos/200?seed=23",
          ),
          Grid(
            title: "Indie",
            ImageUrl: "https://picsum.photos/200?seed=34",
          ),
          Grid(
            title: "Dance",
            ImageUrl: "https://picsum.photos/200?seed=24",
          ),
          Grid(
            title: "Latin",
            ImageUrl: "https://picsum.photos/200?seed=234",
          ),
        ];
        return GridItemWidget(
          index: index,
          grid: gridlist[index],
        );
      },
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final int index;
  final Grid grid;

  GridItemWidget({required this.index, required this.grid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => browse(grid: grid),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Display the text on the left
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  grid.title,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            // Display a smaller image on the right
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 100, // Adjust the width as needed
              height: 100, // Adjust the height as needed
              child: Transform.rotate(
                angle: 30 * 3.14 / 180,
                child: Image.network(grid.ImageUrl,
                    width: 100, height: 100, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LyricsWidget extends StatelessWidget {
  final String lyrics;

  LyricsWidget({required this.lyrics});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        lyrics,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
