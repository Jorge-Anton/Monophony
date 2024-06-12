// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_artist_albums.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getArtistAlbumsHash() => r'197c75b5f3e4bd73decd8d6c567ce565b69426e9';

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

/// See also [getArtistAlbums].
@ProviderFor(getArtistAlbums)
const getArtistAlbumsProvider = GetArtistAlbumsFamily();

/// See also [getArtistAlbums].
class GetArtistAlbumsFamily extends Family<AsyncValue<List<AlbumModel>?>> {
  /// See also [getArtistAlbums].
  const GetArtistAlbumsFamily();

  /// See also [getArtistAlbums].
  GetArtistAlbumsProvider call(
    String artistId,
  ) {
    return GetArtistAlbumsProvider(
      artistId,
    );
  }

  @override
  GetArtistAlbumsProvider getProviderOverride(
    covariant GetArtistAlbumsProvider provider,
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
  String? get name => r'getArtistAlbumsProvider';
}

/// See also [getArtistAlbums].
class GetArtistAlbumsProvider
    extends AutoDisposeFutureProvider<List<AlbumModel>?> {
  /// See also [getArtistAlbums].
  GetArtistAlbumsProvider(
    String artistId,
  ) : this._internal(
          (ref) => getArtistAlbums(
            ref as GetArtistAlbumsRef,
            artistId,
          ),
          from: getArtistAlbumsProvider,
          name: r'getArtistAlbumsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArtistAlbumsHash,
          dependencies: GetArtistAlbumsFamily._dependencies,
          allTransitiveDependencies:
              GetArtistAlbumsFamily._allTransitiveDependencies,
          artistId: artistId,
        );

  GetArtistAlbumsProvider._internal(
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
    FutureOr<List<AlbumModel>?> Function(GetArtistAlbumsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetArtistAlbumsProvider._internal(
        (ref) => create(ref as GetArtistAlbumsRef),
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
  AutoDisposeFutureProviderElement<List<AlbumModel>?> createElement() {
    return _GetArtistAlbumsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetArtistAlbumsProvider && other.artistId == artistId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, artistId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetArtistAlbumsRef on AutoDisposeFutureProviderRef<List<AlbumModel>?> {
  /// The parameter `artistId` of this provider.
  String get artistId;
}

class _GetArtistAlbumsProviderElement
    extends AutoDisposeFutureProviderElement<List<AlbumModel>?>
    with GetArtistAlbumsRef {
  _GetArtistAlbumsProviderElement(super.provider);

  @override
  String get artistId => (origin as GetArtistAlbumsProvider).artistId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
