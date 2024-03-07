// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i3;

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:restaurant_ratings/injectable.dart' as _i5;
import 'package:restaurant_ratings/restaurant/domain/restaurant_repository.dart'
    as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.File>(
      () => appModule.db,
      preResolve: true,
    );
    gh.lazySingleton<_i4.RestaurantRepository>(
        () => _i4.FirRestaurantRepository(gh<_i3.File>()));
    return this;
  }
}

class _$AppModule extends _i5.AppModule {}
