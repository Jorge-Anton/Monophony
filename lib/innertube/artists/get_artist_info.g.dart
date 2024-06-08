// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_artist_info.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getArtistInfoHash() => r'805c26005acb571194f2222a7572350eab691a3d';

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

/// See also [getArtistInfo].
@ProviderFor(getArtistInfo)
const getArtistInfoProvider = GetArtistInfoFamily();

/// See also [getArtistInfo].
class GetArtistInfoFamily extends Family<AsyncValue<ArtistPage>> {
  /// See also [getArtistInfo].
  const GetArtistInfoFamily();

  /// See also [getArtistInfo].
  GetArtistInfoProvider call(
    String artistId,
  ) {
    return GetArtistInfoProvider(
      artistId,
    );
  }

  @override
  GetArtistInfoProvider getProviderOverride(
    covariant GetArtistInfoProvider provider,
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
  String? get name => r'getArtistInfoProvider';
}

/// See also [getArtistInfo].
class GetArtistInfoProvider extends FutureProvider<ArtistPage> {
  /// See also [getArtistInfo].
  GetArtistInfoProvider(
    String artistId,
  ) : this._internal(
          (ref) => getArtistInfo(
            ref as GetArtistInfoRef,
            artistId,
          ),
          from: getArtistInfoProvider,
          name: r'getArtistInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArtistInfoHash,
          dependencies: GetArtistInfoFamily._dependencies,
          allTransitiveDependencies:
              GetArtistInfoFamily._allTransitiveDependencies,
          artistId: artistId,
        );

  GetArtistInfoProvider._internal(
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
    FutureOr<ArtistPage> Function(GetArtistInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetArtistInfoProvider._internal(
        (ref) => create(ref as GetArtistInfoRef),
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
  FutureProviderElement<ArtistPage> createElement() {
    return _GetArtistInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetArtistInfoProvider && other.artistId == artistId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, artistId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetArtistInfoRef on FutureProviderRef<ArtistPage> {
  /// The parameter `artistId` of this provider.
  String get artistId;
}

class _GetArtistInfoProviderElement extends FutureProviderElement<ArtistPage>
    with GetArtistInfoRef {
  _GetArtistInfoProviderElement(super.provider);

  @override
  String get artistId => (origin as GetArtistInfoProvider).artistId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
