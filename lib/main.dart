// An example of localizing a Flutter app written with the
// Dart intl package (see https://pub.dartlang.org/packages/intl).
// Includes script for continuous integration of .arb extraction/generation.
//
// See lib/localization.dart for detailed information

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization.dart';

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context).welcomeText),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('pt', ''),
        const Locale('sk', ''),
      ],
      // IMPORTANT: The following steps MUST also coincide with supportedLocales
      // 1. Add the above supported locales to isSupported in lib/localization.dart
      // 2. For iOS, update ios/Runner/Info.plist using the following example
/*
	<key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
		<string>pt</string>
		<string>sk</string>
	</array>
*/
      // Watch out: MaterialApp creates a Localizations widget
      // with the specified delegates. AppLocalizations.of()
      // will only find the app's Localizations widget if its
      // context is a child of the app.
      home: DemoApp(),
    );
  }
}

void main() {
  runApp(Demo());
}
