// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_lists.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getListsHash() => r'd79525eac619f4bde7212b14137ffa5b78c9de97';

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

/// See also [getLists].
@ProviderFor(getLists)
const getListsProvider = GetListsFamily();

/// See also [getLists].
class GetListsFamily extends Family<AsyncValue<List<ListModel>?>> {
  /// See also [getLists].
  const GetListsFamily();

  /// See also [getLists].
  GetListsProvider call(
    String query,
  ) {
    return GetListsProvider(
      query,
    );
  }

  @override
  GetListsProvider getProviderOverride(
    covariant GetListsProvider provider,
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
  String? get name => r'getListsProvider';
}

/// See also [getLists].
class GetListsProvider extends FutureProvider<List<ListModel>?> {
  /// See also [getLists].
  GetListsProvider(
    String query,
  ) : this._internal(
          (ref) => getLists(
            ref as GetListsRef,
            query,
          ),
          from: getListsProvider,
          name: r'getListsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListsHash,
          dependencies: GetListsFamily._dependencies,
          allTransitiveDependencies: GetListsFamily._allTransitiveDependencies,
          query: query,
        );

  GetListsProvider._internal(
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
    FutureOr<List<ListModel>?> Function(GetListsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListsProvider._internal(
        (ref) => create(ref as GetListsRef),
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
  FutureProviderElement<List<ListModel>?> createElement() {
    return _GetListsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListsRef on FutureProviderRef<List<ListModel>?> {
  /// The parameter `query` of this provider.
  String get query;
}

class _GetListsProviderElement extends FutureProviderElement<List<ListModel>?>
    with GetListsRef {
  _GetListsProviderElement(super.provider);

  @override
  String get query => (origin as GetListsProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
