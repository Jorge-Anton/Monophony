// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_songs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSongsHash() => r'23564ad0f907c47aa07d16fb7261dac104435b35';

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

/// See also [getSongs].
@ProviderFor(getSongs)
const getSongsProvider = GetSongsFamily();

/// See also [getSongs].
class GetSongsFamily extends Family<AsyncValue<List<SongModel>>> {
  /// See also [getSongs].
  const GetSongsFamily();

  /// See also [getSongs].
  GetSongsProvider call(
    String query,
  ) {
    return GetSongsProvider(
      query,
    );
  }

  @override
  GetSongsProvider getProviderOverride(
    covariant GetSongsProvider provider,
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
  String? get name => r'getSongsProvider';
}

/// See also [getSongs].
class GetSongsProvider extends FutureProvider<List<SongModel>> {
  /// See also [getSongs].
  GetSongsProvider(
    String query,
  ) : this._internal(
          (ref) => getSongs(
            ref as GetSongsRef,
            query,
          ),
          from: getSongsProvider,
          name: r'getSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSongsHash,
          dependencies: GetSongsFamily._dependencies,
          allTransitiveDependencies: GetSongsFamily._allTransitiveDependencies,
          query: query,
        );

  GetSongsProvider._internal(
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
    FutureOr<List<SongModel>> Function(GetSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSongsProvider._internal(
        (ref) => create(ref as GetSongsRef),
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
  FutureProviderElement<List<SongModel>> createElement() {
    return _GetSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSongsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSongsRef on FutureProviderRef<List<SongModel>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _GetSongsProviderElement extends FutureProviderElement<List<SongModel>>
    with GetSongsRef {
  _GetSongsProviderElement(super.provider);

  @override
  String get query => (origin as GetSongsProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
