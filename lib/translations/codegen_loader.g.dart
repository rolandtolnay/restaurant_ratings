// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> hu = {
  "app_name": "Éttermek",
  "search": "Keresés",
  "error": "Hiba történt. Kérjük, próbálja újra.",
  "retry": "Újra",
  "add_new": "+ Új hozzáadása",
  "reviews": "Értékelések",
  "name": "Név",
  "review": "Értékelés",
  "add_review": "Értékelés hozzáadása"
};
static const Map<String,dynamic> en = {
  "app_name": "Restaurants",
  "search": "Search",
  "error": "There was an issue. Please try again.",
  "retry": "Retry",
  "add_new": "+ Add new",
  "reviews": "Reviews",
  "name": "Name",
  "review": "Review",
  "add_review": "Add review"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"hu": hu, "en": en};
}
