// An example of localizing a Flutter app written with the
// Dart intl package (see https://pub.dartlang.org/packages/intl).
// Includes script for continuous integration of .arb extraction/generation.

// The pubspec.yaml file must include flutter_localizations and the
// Dart intl packages in its dependencies section. For example:
//
// dependencies:
//   flutter:
//     sdk: flutter
//   flutter_localizations:
//     sdk: flutter
//   intl: ^0.15.8
//
// dev_dependencies:
//   flutter_test:
//     sdk: flutter
//   intl_translation: ^0.17.5

// If you run this app with the device's locale set to an unsupported
// locale, the app's locale will default to English. If you set the
// device's *preferred* locale to Spanish, and Spanish is supported in
// the app, the app's locale will be Spanish.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// The file lib/l10n/messages_all.dart was generated in two steps, using the
// Dart intl tools. With the app's root directory (the one that contains
// pubspec.yaml) as the current directory:
//
// mkdir l10n-arb; flutter pub pub run intl_translation:extract_to_arb --output-dir=l10n-arb lib/localization.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization.dart l10n-translated/*/l10n/intl_messages_*.arb
// rm -rf l10n-arb
//
// The first flutter pub command generates intl_messages.arb and
// the third generates messages_all.dart. There's more about this process in
// https://pub.dev/packages/intl.
//
// Use the included script in the app's scripts directory to integrate
// localization updates into your continuous integration workflow.
// IMPORTANT: run this script from your Flutter app root directory
// (the one that contains pubspec.yaml):
//
//   ./scripts/update-l10n.sh
//
import 'l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null || locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    // TODO Remove print() in your production code
    print('locale.countryCode: ${locale.countryCode}');
    print('locale.languageCode: ${locale.languageCode}');
    print('locale: ${name}');
    print('localeName: ${localeName}');

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      // TODO Remove print() in your production code
      print('intl default locale: ${Intl.defaultLocale}');
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // IMPORTANT: Default localization strings must be added below. They are
  // the building blocks for intl_translation:extract_to_arb (see notes above).
  //
  // Messages to be localized are written as functions that return
  // the result of an Intl.message call.
  //
  // For more information see https://pub.dev/packages/intl
  /*
  String continueMessage() => Intl.message(
      "Hit any key to continue",
      name: "continueMessage",
      args: [],
      desc: "Explains that we will not proceed further until "
          "the user presses a key");
  print(continueMessage());
  */
  String get appTitle => Intl.message('My localized app', name: 'appTitle', desc: 'Title for the application');
  String get welcomeText => Intl.message('Hello world!', name: 'welcomeText');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es', 'pt', 'sk'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
