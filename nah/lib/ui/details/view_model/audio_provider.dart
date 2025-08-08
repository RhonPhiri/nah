import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:nah/data/models/hymn_model.dart';

//Class to manage the state and functionality of audio of hymn
class AudioProvider with ChangeNotifier {
  late AudioPlayer _player;
  final Hymn hymn;

  ///Variable to hold the state of searching the hymn asset file. When true, a circular progress indicator will be shown
  bool searchingAudio = false;

  ///Variable to show if an audio asset for this hymn is vailable. When true, a play_arrow button will be shown
  bool hasAudio = false;

  ///Variable to hold the playing state of _player.
  bool isPlaying = false;

  AudioProvider({required this.hymn}) {
    //The audio player is assigned upon calling the constructor
    _player = AudioPlayer(playerId: "${hymn.id}${hymn.title}");
    debugPrint("AUDIO PROVIDER: Player ${_player.playerId} assinged");
    setAudioSource();
  }

  ///Getter to check if a particular hymn has an audio asset or not. If audio is present, it is assigned to the player
  Future<void> setAudioSource() async {
    try {
      //Variable to hold the index of the first seperator in other details of a hymn
      final index = hymn.otherDetails.indexOf("\n");
      searchingAudio = true;
      notifyListeners();
      await _player.setSourceAsset(
        "audios/${hymn.otherDetails.substring(0, index)}.mid",
      );
      debugPrint("AUDIO PROVIDER: Audio for ${hymn.title} has been set");
      hasAudio = true;
      searchingAudio = false;
    } catch (e) {
      debugPrint("AUDIO PROVIDER: Failed to set Audio for ${hymn.title}");
      hasAudio = false;
      searchingAudio = false;
    }
    notifyListeners();
  }

  ///Method to handle the playing state of _player
  void handlePlayer() {
    switch (isPlaying) {
      case true:
        _player.pause();
        debugPrint("AUDIO PROVIDER: Stopped playing ${hymn.title}");
        break;
      case false:
        _player.play(_player.source!);
        debugPrint("AUDIO PROVIDER: playing ${hymn.title}");
        break;
    }
    isPlaying = !isPlaying;

    notifyListeners();
  }

  ///Method to dispose of the _player and provider
  @override
  void dispose() {
    _player.dispose();
    debugPrint("Audio PROVIDER: Resources disposed successfully");

    super.dispose();
  }
}
