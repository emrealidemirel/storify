# Storify screenshots

These images render the app's production HomePage, ThemeSelectionPage, and StoryPage widgets with the actual bundled fonts, translations, artwork, and guest story assets. They are Flutter widget captures, not physical-device or store-validation evidence. Story captures use the adventure story and Ada as the protagonist. No generated story, live account, provider request, or credential is used.

Each locale has home, selection, story, and dark story captures. The viewport is 430 × 1100 logical pixels, exported at 2× (860 × 2200). Selection is the initial, unselected screen; scroll to reach the remaining controls in the app.

From the repository root:

```sh
flutter pub get
# Only needed on a fresh checkout: Flutter currently declares .env as an asset.
# Preserve an existing local .env; this command does not overwrite it.
[ -f .env ] || cp .env.example .env
flutter test --no-pub --dart-define=CAPTURE_SCREENSHOTS=true test/screenshots/capture_test.dart
```

The capture harness uses a local authentication stub and the normal guest-story repository. It checks for rendering errors and verifies that story content has loaded before exporting PNGs. The English and Turkish READMEs use their respective language's captures. Review all images visually after changing widgets, translations, fonts, or the Flutter version.

Captures are opt-in: the ordinary Flutter test suite skips these eight export cases to keep checked-in images unchanged.
