// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_artist_songs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getArtistSongsHash() => r'1c67f1962be86d47462b4c6806753be2234929f0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getArtistSongs].
@ProviderFor(getArtistSongs)
const getArtistSongsProvider = GetArtistSongsFamily();

/// See also [getArtistSongs].
class GetArtistSongsFamily extends Family<AsyncValue<List<SongModel>?>> {
  /// See also [getArtistSongs].
  const GetArtistSongsFamily();

  /// See also [getArtistSongs].
  GetArtistSongsProvider call(
    String artistId,
  ) {
    return GetArtistSongsProvider(
      artistId,
    );
  }

  @override
  GetArtistSongsProvider getProviderOverride(
    covariant GetArtistSongsProvider provider,
  ) {
    return call(
      provider.artistId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getArtistSongsProvider';
}

/// See also [getArtistSongs].
class GetArtistSongsProvider extends FutureProvider<List<SongModel>?> {
  /// See also [getArtistSongs].
  GetArtistSongsProvider(
    String artistId,
  ) : this._internal(
          (ref) => getArtistSongs(
            ref as GetArtistSongsRef,
            artistId,
          ),
          from: getArtistSongsProvider,
          name: r'getArtistSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArtistSongsHash,
          dependencies: GetArtistSongsFamily._dependencies,
          allTransitiveDependencies:
              GetArtistSongsFamily._allTransitiveDependencies,
          artistId: artistId,
        );

  GetArtistSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.artistId,
  }) : super.internal();

  final String artistId;

  @override
  Override overrideWith(
    FutureOr<List<SongModel>?> Function(GetArtistSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetArtistSongsProvider._internal(
        (ref) => create(ref as GetArtistSongsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        artistId: artistId,
      ),
    );
  }

  @override
  FutureProviderElement<List<SongModel>?> createElement() {
    return _GetArtistSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetArtistSongsProvider && other.artistId == artistId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, artistId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetArtistSongsRef on FutureProviderRef<List<SongModel>?> {
  /// The parameter `artistId` of this provider.
  String get artistId;
}

class _GetArtistSongsProviderElement
    extends FutureProviderElement<List<SongModel>?> with GetArtistSongsRef {
  _GetArtistSongsProviderElement(super.provider);

  @override
  String get artistId => (origin as GetArtistSongsProvider).artistId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
