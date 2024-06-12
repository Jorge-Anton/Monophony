import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:monophony/innertube/get_shuffle.dart';
import 'package:monophony/innertube/models/navigation_endpoint.dart';
import 'package:monophony/notifiers/selected_song_notifier.dart';
import 'package:monophony/models/song_model.dart';
import 'package:monophony/notifiers/play_button_notifier.dart';
import 'package:monophony/notifiers/progress_notifier.dart';
import 'package:monophony/notifiers/repeat_one_button_notifier.dart';
import 'package:monophony/notifiers/repeat_playlist_button_notifier.dart';
import 'package:monophony/innertube/get_queue.dart';

import '../services/service_locator.dart';


class AudioController  {
  final currentSongNotifier = ValueNotifier<SongModel?>(null);
  final playlistNotifier = ValueNotifier<List<SongModel>>([]);
  final progressNotifier = ProgressNotifier();
  final playButtonNotifier = PlayButtonNotifier();
  final repeatOneButtonNotifier = RepeatOneButtonNotifier();
  final repeatPlaylistButtonNotifier = RepeatPlaylistButtonNotifier();
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();

  void init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    // await _loadPlaylist();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  Future<void> loadPlaylist() async {
    await stop();
    seek(Duration.zero);
    await _audioHandler.customAction('clear');
    final SelectedSongNotifier selectedSongNotifier = getIt<SelectedSongNotifier>();
    final firstSong = selectedSongNotifier.value;
    
    if (firstSong != null) {
      await _audioHandler.addQueueItem(firstSong);

      play();

      final playlist = await getQueue(firstSong.id);
      if (playlist != null) {
        playlist.removeAt(0);
        _audioHandler.addQueueItems(playlist);
      }
    }
  }

  Future<void> loadShuffle(Watch? endpoint) async {
    if (endpoint == null) return;
    await stop();
    seek(Duration.zero);
    await _audioHandler.customAction('clear');

    final List<SongModel>? playlist = await getShuffle(endpoint.videoId ?? '', endpoint.playlistId ?? '', endpoint.params ?? '');
    if (playlist != null) {
      await _audioHandler.addQueueItems(playlist);
      play();
      getIt<SelectedSongNotifier>().setActiveSong(playlist.first);
    }
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      playlistNotifier.value = playlist.map((item) => SongModel.fromMediaItem(item)).toList();
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
      if (mediaItem == null) {
        currentSongNotifier.value = null;
      } else {
        currentSongNotifier.value = SongModel.fromMediaItem(mediaItem);
      }
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

  void skipToItem(SongModel mediaItem) {
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
        'song': song,
        'index': playlistNotifier.value.indexOf(currentSongNotifier.value!) + 1
      }
    );
  }

  Future<void> add(SongModel song) async {
    final mediaItem = MediaItem(
      id: song.id, 
      title: song.title,
      artist: song.artist,
      artUri: song.artUri,
      duration: song.duration
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

  Future<void> stop() async {
    await _audioHandler.stop();
    currentSongNotifier.value = null;
  }
}