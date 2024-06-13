// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_songs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getListSongsHash() => r'93e821e59b4dcf1445ce0c4d85df3851430cc222';

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

/// See also [getListSongs].
@ProviderFor(getListSongs)
const getListSongsProvider = GetListSongsFamily();

/// See also [getListSongs].
class GetListSongsFamily extends Family<AsyncValue<List<SongModel>?>> {
  /// See also [getListSongs].
  const GetListSongsFamily();

  /// See also [getListSongs].
  GetListSongsProvider call(
    String browseId,
  ) {
    return GetListSongsProvider(
      browseId,
    );
  }

  @override
  GetListSongsProvider getProviderOverride(
    covariant GetListSongsProvider provider,
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
  String? get name => r'getListSongsProvider';
}

/// See also [getListSongs].
class GetListSongsProvider extends FutureProvider<List<SongModel>?> {
  /// See also [getListSongs].
  GetListSongsProvider(
    String browseId,
  ) : this._internal(
          (ref) => getListSongs(
            ref as GetListSongsRef,
            browseId,
          ),
          from: getListSongsProvider,
          name: r'getListSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListSongsHash,
          dependencies: GetListSongsFamily._dependencies,
          allTransitiveDependencies:
              GetListSongsFamily._allTransitiveDependencies,
          browseId: browseId,
        );

  GetListSongsProvider._internal(
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
    FutureOr<List<SongModel>?> Function(GetListSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListSongsProvider._internal(
        (ref) => create(ref as GetListSongsRef),
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
    return _GetListSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListSongsProvider && other.browseId == browseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, browseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListSongsRef on FutureProviderRef<List<SongModel>?> {
  /// The parameter `browseId` of this provider.
  String get browseId;
}

class _GetListSongsProviderElement
    extends FutureProviderElement<List<SongModel>?> with GetListSongsRef {
  _GetListSongsProviderElement(super.provider);

  @override
  String get browseId => (origin as GetListSongsProvider).browseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
