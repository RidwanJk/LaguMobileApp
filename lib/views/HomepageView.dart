import 'package:flutter/material.dart';
import 'package:myapp/model/song_model.dart';
import 'package:myapp/views/song_details_page.dart';
import 'package:myapp/widgets/custom_widged.dart';
import 'package:myapp/model/playlist_model.dart';

class MyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(child: buildTombol(context, "Music")),
                    Flexible(
                      child: buildTombol(context, "Podcast"),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 500,
                    height: 200,
                    child: PlaylistGrid(playlists: PlayListModel),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Avatar(
                              imageUrl:
                                  "https://geo-media.beatsource.com/image_size/1400x1400/a/0/d/a0d74f31-2b81-4d5f-a5e5-531ffa13c231.jpg"),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Release From ",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: "Inter-Reguler",
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Oliver Tree",
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
                      SizedBox(
                        height: 20,
                      ),
                      BigCard(
                        title: "Miss You",
                        subtitle: "Oliver Tree·Robin Schulz",
                        imageUrl:
                            "https://geo-media.beatsource.com/image_size/1400x1400/a/0/d/a0d74f31-2b81-4d5f-a5e5-531ffa13c231.jpg",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongDetailsPage(
                                song: Song(
                                  rank: 4,
                                  title: "Miss You",
                                  artist: "Oliver Tree, Robin Schulz",
                                  album: "Miss You",
                                  year: "2022",
                                  ImageUrl:
                                      "https://geo-media.beatsource.com/image_size/1400x1400/a/0/d/a0d74f31-2b81-4d5f-a5e5-531ffa13c231.jpg",
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 3),
                        child: Text(
                          "Best of The Year ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "Inter-Bold",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 400,
                        child: SongListView(),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
