// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$viewModelHash() => r'5b6ceeeb6de6126fa3b406706a346421bce206ec';

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

abstract class _$ViewModel extends BuildlessAutoDisposeNotifier<State> {
  late final String roomId;

  State build(
    String roomId,
  );
}

/// See also [ViewModel].
@ProviderFor(ViewModel)
const viewModelProvider = ViewModelFamily();

/// See also [ViewModel].
class ViewModelFamily extends Family<State> {
  /// See also [ViewModel].
  const ViewModelFamily();

  /// See also [ViewModel].
  ViewModelProvider call(
    String roomId,
  ) {
    return ViewModelProvider(
      roomId,
    );
  }

  @override
  ViewModelProvider getProviderOverride(
    covariant ViewModelProvider provider,
  ) {
    return call(
      provider.roomId,
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
  String? get name => r'viewModelProvider';
}

/// See also [ViewModel].
class ViewModelProvider
    extends AutoDisposeNotifierProviderImpl<ViewModel, State> {
  /// See also [ViewModel].
  ViewModelProvider(
    String roomId,
  ) : this._internal(
          () => ViewModel()..roomId = roomId,
          from: viewModelProvider,
          name: r'viewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$viewModelHash,
          dependencies: ViewModelFamily._dependencies,
          allTransitiveDependencies: ViewModelFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  ViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  State runNotifierBuild(
    covariant ViewModel notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }

  @override
  Override overrideWith(ViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ViewModelProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ViewModel, State> createElement() {
    return _ViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ViewModelProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ViewModelRef on AutoDisposeNotifierProviderRef<State> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _ViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<ViewModel, State>
    with ViewModelRef {
  _ViewModelProviderElement(super.provider);

  @override
  String get roomId => (origin as ViewModelProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
