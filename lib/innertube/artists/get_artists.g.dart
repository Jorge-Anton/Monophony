// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_artists.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getArtistsHash() => r'39371369db73bf1c4f7f0c5af0684e1f1cbf0ec2';

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

/// See also [getArtists].
@ProviderFor(getArtists)
const getArtistsProvider = GetArtistsFamily();

/// See also [getArtists].
class GetArtistsFamily extends Family<AsyncValue<List<ArtistModel>?>> {
  /// See also [getArtists].
  const GetArtistsFamily();

  /// See also [getArtists].
  GetArtistsProvider call(
    String query,
  ) {
    return GetArtistsProvider(
      query,
    );
  }

  @override
  GetArtistsProvider getProviderOverride(
    covariant GetArtistsProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'getArtistsProvider';
}

/// See also [getArtists].
class GetArtistsProvider extends FutureProvider<List<ArtistModel>?> {
  /// See also [getArtists].
  GetArtistsProvider(
    String query,
  ) : this._internal(
          (ref) => getArtists(
            ref as GetArtistsRef,
            query,
          ),
          from: getArtistsProvider,
          name: r'getArtistsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArtistsHash,
          dependencies: GetArtistsFamily._dependencies,
          allTransitiveDependencies:
              GetArtistsFamily._allTransitiveDependencies,
          query: query,
        );

  GetArtistsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<ArtistModel>?> Function(GetArtistsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetArtistsProvider._internal(
        (ref) => create(ref as GetArtistsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  FutureProviderElement<List<ArtistModel>?> createElement() {
    return _GetArtistsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetArtistsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetArtistsRef on FutureProviderRef<List<ArtistModel>?> {
  /// The parameter `query` of this provider.
  String get query;
}

class _GetArtistsProviderElement
    extends FutureProviderElement<List<ArtistModel>?> with GetArtistsRef {
  _GetArtistsProviderElement(super.provider);

  @override
  String get query => (origin as GetArtistsProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
