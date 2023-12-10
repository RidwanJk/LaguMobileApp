import 'package:flutter/material.dart';
import 'package:myapp/model/song_model.dart';
import 'package:myapp/widgets/custom_widged.dart';
import 'package:audioplayers/audioplayers.dart';

class SongDetailsPage extends StatefulWidget {
  final Song song;

  const SongDetailsPage({Key? key, required this.song}) : super(key: key);

  @override
  _SongDetailsPageState createState() => _SongDetailsPageState();
}

class _SongDetailsPageState extends State<SongDetailsPage> {
  bool isLoved = false;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final playeraudio = AudioPlayer();
  @override
  void initState() {
    super.initState();

    setAudio(widget.song.mp3Url);

    playeraudio.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    playeraudio.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    playeraudio.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio(urlaudio) async {
    playeraudio.setReleaseMode(ReleaseMode.loop);

    playeraudio.setSourceUrl(urlaudio);
  }

  @override
  Widget build(BuildContext context) {
    final songDetail = widget.song;

    return Scaffold(
      appBar: AppBar(
        title: Text(songDetail.title),
      ),
      backgroundColor: Color.fromARGB(255, 19, 5, 49),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Your song details UI widgets
            SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      18), // Adjust this to match the outer border
                  child: Image.network(
                    songDetail.imageUrl,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              songDetail.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            Text(
              "${songDetail.artistName}",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 16),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await playeraudio.seek(position);
                await playeraudio.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(position),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    formatTime(duration),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: 32,
                  color: Colors.white,
                  onPressed: () async {
                    if (isPlaying) {
                      await playeraudio.pause();
                    } else {
                      await playeraudio.resume();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            Container(
              child: lyricsWidget(context),
            )
          ],
        ),
      ),
    );
  }

  Widget lyricsWidget(BuildContext context) {
    final lyrics = widget.song.Lirik ?? 'Lyrics not available';
    return Card(
      
      color: Color.fromARGB(255, 183, 0, 255),
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            lyrics,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
