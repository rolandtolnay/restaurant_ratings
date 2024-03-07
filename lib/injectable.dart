import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import 'injectable.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class AppModule {
  @preResolve
  Future<File> get db async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/restaurants.json';

    final file = File(path);
    if (!file.existsSync()) {
      final bundledJson = await rootBundle.loadString(
        'assets/restaurants.json',
      );
      await file.writeAsString(bundledJson);
    }
    return file;
  }
}
