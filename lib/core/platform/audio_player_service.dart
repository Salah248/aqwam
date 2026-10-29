abstract interface class AudioPlayerService {
  Future<void> play(String source);
  Future<void> pause();
  Future<void> stop();
}
