// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_album_songs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAlbumSongsHash() => r'6d1c9cf330100882cc9fe92323630aa545c8f17c';

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

/// See also [getAlbumSongs].
@ProviderFor(getAlbumSongs)
const getAlbumSongsProvider = GetAlbumSongsFamily();

/// See also [getAlbumSongs].
class GetAlbumSongsFamily extends Family<AsyncValue<List<SongModel>?>> {
  /// See also [getAlbumSongs].
  const GetAlbumSongsFamily();

  /// See also [getAlbumSongs].
  GetAlbumSongsProvider call(
    String browseId,
  ) {
    return GetAlbumSongsProvider(
      browseId,
    );
  }

  @override
  GetAlbumSongsProvider getProviderOverride(
    covariant GetAlbumSongsProvider provider,
  ) {
    return call(
      provider.browseId,
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
  String? get name => r'getAlbumSongsProvider';
}

/// See also [getAlbumSongs].
class GetAlbumSongsProvider extends FutureProvider<List<SongModel>?> {
  /// See also [getAlbumSongs].
  GetAlbumSongsProvider(
    String browseId,
  ) : this._internal(
          (ref) => getAlbumSongs(
            ref as GetAlbumSongsRef,
            browseId,
          ),
          from: getAlbumSongsProvider,
          name: r'getAlbumSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAlbumSongsHash,
          dependencies: GetAlbumSongsFamily._dependencies,
          allTransitiveDependencies:
              GetAlbumSongsFamily._allTransitiveDependencies,
          browseId: browseId,
        );

  GetAlbumSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.browseId,
  }) : super.internal();

  final String browseId;

  @override
  Override overrideWith(
    FutureOr<List<SongModel>?> Function(GetAlbumSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAlbumSongsProvider._internal(
        (ref) => create(ref as GetAlbumSongsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        browseId: browseId,
      ),
    );
  }

  @override
  FutureProviderElement<List<SongModel>?> createElement() {
    return _GetAlbumSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAlbumSongsProvider && other.browseId == browseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, browseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAlbumSongsRef on FutureProviderRef<List<SongModel>?> {
  /// The parameter `browseId` of this provider.
  String get browseId;
}

class _GetAlbumSongsProviderElement
    extends FutureProviderElement<List<SongModel>?> with GetAlbumSongsRef {
  _GetAlbumSongsProviderElement(super.provider);

  @override
  String get browseId => (origin as GetAlbumSongsProvider).browseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
