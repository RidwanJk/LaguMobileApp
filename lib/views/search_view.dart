import 'package:flutter/material.dart';
import 'package:myapp/model/Category_model.dart';
import 'package:myapp/model/song_model.dart';
import 'package:myapp/views/category_detail_page.dart';
import 'package:myapp/views/song_details_page.dart';
import 'package:myapp/widgets/custom_widged.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Category> categories = [];
  List<Song> songs = [];
  final TextEditingController _searchController = TextEditingController();
  bool showSearchResults = false;
  @override
  void initState() {
    super.initState();
    String searchText = _searchController.text;
    fetchCategories();
    SongsSearch(searchText);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  fetchCategories() async {
    try {
      List<Category> fetchedsongs = await Category.fetchCategories();
      setState(() {
        categories = fetchedsongs;
      });
    } catch (e) {
      print('Error fetching Category: $e');
    }
  }

  SongsSearch(String cari) async {
    try {
      List<Song> fetchedsongs = await Song.fetchSongsSearch(cari);
      setState(() {
        songs = fetchedsongs;
        print(songs);
      });
    } catch (e) {
      print('Error fetching Category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: const Color.fromARGB(255, 19, 5, 49),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Search",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: "Inter-Bold",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(child: SearchBox(context), width: 333),
                      InkWell(
                        onTap: () {
                          print("Search");
                        },
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white, // Set the color to white
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Visibility(
              visible: !showSearchResults,
              child: Flexible(child: GridViewSearch(context)),
            ),
            Visibility(
              visible: showSearchResults,
              child: Resultsong(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget GridViewSearch(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 1.75,
      ),
      itemCount: categories.length, // Number of items in the grid
      itemBuilder: (BuildContext context, int index) {
        return GridItemWidget(context, index);
      },
    );
  }

  Widget GridItemWidget(BuildContext context, int index) {
    final category = categories[index];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => categorydetail(category: category),
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
                  categories[index].name,
                  style: const TextStyle(
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
                child: Image.network(categories[index].imageUrl,
                    width: 100, height: 100, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SearchBox(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // Background color when not focused
        hintText: "Search Song, Lyrics or Artist",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(
                255, 89, 89, 89), // Background color when focused
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          String searchText = value;
          SongsSearch(searchText);
          showSearchResults = true;
          print(value);
        } else {
          setState(() {
            showSearchResults = false;
          });
        }
      },
    );
  }

  Widget Resultsong(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
              "${index + 1}" + ".",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            title: Row(
              children: [
                Image.network(songs[index].imageUrl, width: 70, height: 70),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180,
                      child: Text(
                        songs[index].title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Text(
                      songs[index].artistName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              final song = songs[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongDetailsPage(song: song),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
