import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'a3aV3mKr6Vo',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        isLive: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        aspectRatio: 4 / 3,
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.teal,
        progressColors: const ProgressBarColors(
          playedColor: Colors.teal,
          handleColor: Colors.tealAccent,
        ),
        onReady: () {
          log('Player is ready.');
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: "Video Player",
            actions: [],
          ),
          body: Center(child: player),
        );
      },
    );
  }
}
