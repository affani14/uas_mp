import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var currentPosition = 0.obs;
  var totalDuration = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position.inSeconds;
    });
    _audioPlayer.durationStream.listen((duration) {
      totalDuration.value = duration?.inSeconds ?? 0;
    });
  }

  void playPause() {
    if (isPlaying.value) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  void seekTo(int seconds) {
    _audioPlayer.seek(Duration(seconds: seconds));
  }

  void setAudio(String path) {
    _audioPlayer.setAsset(path);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
