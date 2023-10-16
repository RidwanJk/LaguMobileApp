import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_widged.dart';

class libview extends StatelessWidget {
  const libview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 5, 49),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 5, 49),
          leading: Container(
            margin: EdgeInsets.all(10),
            child: Avatar(
              imageUrl:
                  "https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg",
            ),
          ),
          title: const Text('Your Library'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: TabBar(
              tabs: [
                Tab(text: "Playlists"),
                Tab(text: "Albums"),
                Tab(text: "Artists"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Playlists Tab
            ListView.builder(
              itemCount: 20, // Replace with your playlist count
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "Playlist $index",
                    style: TextStyle(color: Colors.white),
                  ),
                  // Add your custom playlist item design here
                );
              },
            ),

            // Albums Tab
            ListView.builder(
              itemCount: 20, // Replace with your album count
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "Album $index",
                    style: TextStyle(color: Colors.white),
                  ),
                  // Add your custom album item design here
                );
              },
            ),

            // Artists Tab
            ListView.builder(
              itemCount: 20, // Replace with your artist count
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "Artist $index",
                    style: TextStyle(color: Colors.white),
                  ),
                  // Add your custom artist item design here
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
