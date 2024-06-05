import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:monophony/controllers/selected_song_controller.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/notifiers/play_button_notifier.dart';
import 'package:monophony/notifiers/progress_notifier.dart';
import 'package:monophony/notifiers/repeat_one_button_notifier.dart';
import 'package:monophony/notifiers/repeat_playlist_button_notifier.dart';
import 'package:monophony/services/get_queue.dart';
import 'package:monophony/utils/parse_duration.dart';

import '../services/service_locator.dart';

class AudioController {
  final currentSongNotifier = ValueNotifier<MediaItem?>(null);
  final playlistNotifier = ValueNotifier<List<MediaItem>>([]);
  final progressNotifier = ProgressNotifier();
  final playButtonNotifier = PlayButtonNotifier();
  final repeatOneButtonNotifier = RepeatOneButtonNotifier();
  final repeatPlaylistButtonNotifier = RepeatPlaylistButtonNotifier();
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();

  void init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    await _loadPlaylist();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  void loadNewQueue() async {
    await _audioHandler.stop();
    await _audioHandler.seek(Duration.zero);
    // await _audioHandler.customAction('clear');
    init();
    // await _loadPlaylist();
    // await play();
  }

  Future<void> _loadPlaylist() async {
    await _audioHandler.customAction('clear');
    final selectedSongController = getIt<SelectedSongController>();
    final firstSong = selectedSongController.selectedSongNotifier.value;
    if (firstSong != null) {
      await _audioHandler.addQueueItem(
        MediaItem(
          id: firstSong.id, 
          title: firstSong.title,
          artist: firstSong.artists.join(""),
          artUri: Uri.parse('${firstSong.thumbnail}-w896-h896'),
          duration: parseDuration(firstSong.duration),
          extras: {
            'artists': firstSong.artists
          }
        )
      );

      play();

      final playlist = await getQueue(firstSong.id);
      playlist.removeAt(0);
      final List<MediaItem> mediaItems = [];
      for (final song in playlist) {
        mediaItems.add(
          MediaItem(
            id: song.id, 
            title: song.title,
            artist: song.artists.join(""),
            artUri: Uri.parse('${song.thumbnail}-w896-h896'),
            duration: parseDuration(song.duration),
            extras: {
              'artists': song.artists
            }
          )
        );
      }
      _audioHandler.addQueueItems(mediaItems);
    }
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      playlistNotifier.value = playlist;
    });
  }



  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongNotifier.value = mediaItem;
    });
  }

  Future<void> play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() {
    if (repeatOneButtonNotifier.value) {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
      _audioHandler.skipToPrevious();
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
    } else {
      _audioHandler.skipToPrevious();
    }
  }

  void next() {
    if (repeatOneButtonNotifier.value) {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
      _audioHandler.skipToNext();
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
    } else {
      _audioHandler.skipToNext();
    }
  }

  void skipToItem(MediaItem mediaItem) {
    if (playlistNotifier.value.isEmpty) return;
    _audioHandler.skipToQueueItem(playlistNotifier.value.indexOf(mediaItem));
  }

  void repeatOne() {
    repeatOneButtonNotifier.nextState();
    if (repeatOneButtonNotifier.value) {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
    } else if (repeatPlaylistButtonNotifier.value) {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
    } else {
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
    }
  }

  void repeatPlaylist() {
    repeatPlaylistButtonNotifier.nextState();
    if (repeatPlaylistButtonNotifier.value) {
      if (repeatOneButtonNotifier.value) {
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
      } else {
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
      }
    } else {
      if (repeatOneButtonNotifier.value) {
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
      } else {
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
      }
    }
  }

  Future<void> playNext(SongModel song) async {
    _audioHandler.customAction(
      'play next', 
      {
        'song': MediaItem(
          id: song.id, 
          title: song.title,
          artist: song.artists.join(""),
          artUri: Uri.parse('${song.thumbnail}-w896-h896'),
          duration: parseDuration(song.duration)
        ),
        'index': playlistNotifier.value.indexOf(currentSongNotifier.value!) + 1
      }
    );
  }

  Future<void> add(SongModel song) async {
    final mediaItem = MediaItem(
      id: song.id, 
      title: song.title,
      artist: song.artists.join(""),
      artUri: Uri.parse('${song.thumbnail}-w896-h896'),
      duration: parseDuration(song.duration)
    );
    _audioHandler.addQueueItem(mediaItem);
  }

  void remove(int index) {
    _audioHandler.removeQueueItemAt(index);
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}