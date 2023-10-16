import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_widged.dart';
import '../model/song_model.dart';

class SongDetailsPage extends StatefulWidget {
  final Song song;

  SongDetailsPage({required this.song});

  @override
  _SongDetailsPageState createState() => _SongDetailsPageState();
}

class _SongDetailsPageState extends State<SongDetailsPage> {
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
      ),
      backgroundColor: Color.fromARGB(255, 19, 5, 49),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Image.network(
                widget.song.ImageUrl,
                width: 400,
                height: 400,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.song.title}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isLoved ? Icons.favorite : Icons.favorite_border,
                      size: 24,
                      color: isLoved ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isLoved = !isLoved;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "${widget.song.artist}",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:
                      Icon(Icons.skip_previous, size: 36, color: Colors.white),
                  onPressed: () {
                    // Handle skip to the previous action
                    // Implement the logic to skip to the previous song here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.play_arrow, size: 36, color: Colors.white),
                  onPressed: () {
                    // Handle play action
                    // Implement the logic to play the current song here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause, size: 36, color: Colors.white),
                  onPressed: () {
                    // Handle pause action
                    // Implement the logic to pause the currently playing song here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 36, color: Colors.white),
                  onPressed: () {
                    // Handle skip to next action
                    // Implement the logic to skip to the next song here
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            LyricsWidget(
                lyrics:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam volutpat magna sit amet odio euismod aliquam. Proin eget augue ut enim interdum mattis non at dolor. Aenean luctus ante elit, sed imperdiet justo fringilla eu. Sed sit amet eros vel leo luctus varius. Donec vehicula vulputate finibus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam id arcu mollis, blandit tortor a, pharetra nisi. Nulla pellentesque aliquam nunc a iaculis. Mauris metus felis, volutpat pretium rutrum vel, condimentum sed magna. In dapibus ante id ex maximus pulvinar. Curabitur aliquet leo vel ante ultricies, at condimentum nulla mollis. Integer venenatis ligula sit amet ante sodales placerat. Quisque mattis, augue vel ornare facilisis, nisl odio ultrices lectus, vel accumsan nunc enim eget ligula."),
          ],
        ),
      ),
    );
  }
}
