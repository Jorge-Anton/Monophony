// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_albums.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAlbumsHash() => r'ea34e7ca726b03be2cb930869e68c3d1b342a639';

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

/// See also [getAlbums].
@ProviderFor(getAlbums)
const getAlbumsProvider = GetAlbumsFamily();

/// See also [getAlbums].
class GetAlbumsFamily extends Family<AsyncValue<List<AlbumModel>?>> {
  /// See also [getAlbums].
  const GetAlbumsFamily();

  /// See also [getAlbums].
  GetAlbumsProvider call(
    String query,
  ) {
    return GetAlbumsProvider(
      query,
    );
  }

  @override
  GetAlbumsProvider getProviderOverride(
    covariant GetAlbumsProvider provider,
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
  String? get name => r'getAlbumsProvider';
}

/// See also [getAlbums].
class GetAlbumsProvider extends FutureProvider<List<AlbumModel>?> {
  /// See also [getAlbums].
  GetAlbumsProvider(
    String query,
  ) : this._internal(
          (ref) => getAlbums(
            ref as GetAlbumsRef,
            query,
          ),
          from: getAlbumsProvider,
          name: r'getAlbumsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAlbumsHash,
          dependencies: GetAlbumsFamily._dependencies,
          allTransitiveDependencies: GetAlbumsFamily._allTransitiveDependencies,
          query: query,
        );

  GetAlbumsProvider._internal(
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
    FutureOr<List<AlbumModel>?> Function(GetAlbumsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAlbumsProvider._internal(
        (ref) => create(ref as GetAlbumsRef),
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
  FutureProviderElement<List<AlbumModel>?> createElement() {
    return _GetAlbumsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAlbumsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAlbumsRef on FutureProviderRef<List<AlbumModel>?> {
  /// The parameter `query` of this provider.
  String get query;
}

class _GetAlbumsProviderElement extends FutureProviderElement<List<AlbumModel>?>
    with GetAlbumsRef {
  _GetAlbumsProviderElement(super.provider);

  @override
  String get query => (origin as GetAlbumsProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
