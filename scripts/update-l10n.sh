#!/bin/sh -x
# Many thanks to Sam Debruyn for authoring the initial script
# authors:
#  - Sam Debruyn
#  - Lukas Dickie (@lukasgit)

# IMPORTANT: run this script from your Flutter app root directory
# (the one that contains pubspec.yaml):
#
#   ./scripts/update-l10n.sh YOUR_API_KEY
#
# Obtain your free key at https://localise.biz

API_KEY=$1

if [ -z "$API_KEY" ]
then
    echo "API_KEY is empty";
    exit 1;
fi

flutter packages get
mkdir l10n-extracted; flutter pub pub run intl_translation:extract_to_arb --output-dir=l10n-extracted lib/localization.dart
curl -f -s --data-binary "@l10n-extracted/intl_messages.arb" "https://localise.biz/api/import/arb?async=true&index=id&locale=en&key=$API_KEY"
curl -s -o "translated.zip" "https://localise.biz/api/export/archive/arb.zip?key=$API_KEY"
unzip -qq "translated.zip" -d "l10n-translated"
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization.dart l10n-translated/*/l10n/intl_messages_*.arb
rm translated.zip; rm -rf l10n-translated; rm -rf l10n-extracted
echo "finished";

