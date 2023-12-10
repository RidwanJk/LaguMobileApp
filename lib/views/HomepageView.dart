import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/model/Album_model.dart';
import 'package:myapp/model/Category_model.dart';
import 'package:myapp/model/song_model.dart';
import 'package:myapp/views/album_detail_page.dart';
import 'package:myapp/views/category_detail_page.dart';
import 'package:myapp/views/lib_view.dart';
import 'package:myapp/views/song_details_page.dart';
import 'package:myapp/widgets/BotNav.dart';
import 'package:myapp/widgets/custom_widged.dart';

class MyView extends StatefulWidget {
  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  List<Song> songs = [];
  List<Album> albums = [];
  List<Category> categories = [];
  int _randomSongIndex = 0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    fetchSongs();
    fetchCategories();
    fetchAlbums();
  }

  fetchSongs() async {
    try {
      setState(() {
        _loading = true; // Set loading to true before fetching data
      });

      List<Song> fetchedSongs = await Song.fetchSongs();

      setState(() {
        songs = fetchedSongs;
        _setRandomSongIndex();
        _loading = false; // Set loading to false after fetching data
      });
    } catch (e) {
      setState(() {
        _loading = false; // Set loading to false if an error occurs
      });
      print('Error fetching Song: $e');
    }
  }

  fetchCategories() async {
    try {
      _loading = true;
      List<Category> fetchedCategories = await Category.fetchCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      setState(() {
        _loading = false; // Set loading to false if an error occurs
      });
      print('Error fetching Category: $e');
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

  void _setRandomSongIndex() {
    setState(() {
      _randomSongIndex = Random().nextInt(songs.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if songs list is empty or not fetched yet
    if (_loading || songs.isEmpty) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 19, 5, 49),
        body: Center(
          child: CircularProgressIndicator(), // Show loading indicator
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 5, 49),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 5, 49),
        title: const Text('Selamat Datang!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.verified_user),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: buildTombol(context, "Music")),
                  Flexible(child: buildTombol(context, "Podcast")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length > 4 ? 4 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategoryGrid(context, index);
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Avatar(imageUrl: songs[_randomSongIndex].artistImageUrl),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recomended Artist",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "Inter-Reguler",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          songs[_randomSongIndex].artistName,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "Inter-Bold",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 3),
                  child: Text(
                    "Music ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "Inter-Bold",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CardSong(context, _randomSongIndex),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Songs for you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: SongListView(context),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Famous Album',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: AlbumListView(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTombol(BuildContext context, String text) {
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
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return BotNav(selectedIndex: 2);
            },
          ),
        );
      },
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

  Widget CategoryGrid(BuildContext context, int index) {
    return ElevatedButton(
      onPressed: () {
        final category = categories[index];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => categorydetail(category: category),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(113, 0, 0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.zero, // Added to remove default button padding
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: 5), // Adjusted padding
            margin: EdgeInsets.only(left: 5, right: 10), // Adjusted margin
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                categories[index].imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            categories[index].name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget SongListView(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      itemBuilder: (BuildContext context, int index) {
        final song = songs[index];
        return Column(
          children: [
            InkWell(
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
                      image: NetworkImage(songs[index].imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 5, top: 5),
                  child: Text(
                    '${songs[index].albumTitle}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        // Adjust the width of the separator as needed
        return SizedBox(width: 10); // Space between items
      },
    );
  }

  Widget CardSong(BuildContext context, int index) {
    if (_loading) {
      return CircularProgressIndicator();
    } else {
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
                        songs[_randomSongIndex].imageUrl,
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
                          songs[_randomSongIndex].title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          songs[_randomSongIndex].albumTitle,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final song = songs[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongDetailsPage(song: song),
                      ),
                    );
                  },
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

  Widget AlbumListView(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: albums.length,
      itemBuilder: (BuildContext context, int index) {
        final album = albums[index];
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumDetailPage(album: album),
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
                      image: NetworkImage(albums[index].imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5),
                  child: Text(
                    album.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 5, top: 5),
                  child: Text(
                    '${albums[index].title}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 10); // Space between items
      },
    );
  }
}
