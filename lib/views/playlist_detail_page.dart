import 'package:flutter/material.dart';
import '../model/playlist_model.dart';

class PlayListDetail extends StatelessWidget {
  final Playlist PLModel;
  PlayListDetail({required this.PLModel});

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
                "${PLModel.name}",
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
                  PLModel.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Ganti teks dengan gambar dan judul
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0), // Sesuaikan jarak sesuai kebutuhan
                  leading: Text(
                    ' ${index + 1}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Ganti dengan URL gambar Anda
                  title: Row(children: [
                    Image.network(
                      PLModel.imageUrl,
                      width: 70,
                      height: 70,
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      'Item ${index}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ]),
                );
              },
              childCount: 10, // Sesuaikan jumlah item sesuai kebutuhan
            ),
          ),
        ],
      ),
    );
  }
}
