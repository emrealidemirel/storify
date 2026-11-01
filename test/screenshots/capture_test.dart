// Render production widgets with bundled guest stories; no provider requests.
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/auth/auth_cubit.dart';
import 'package:flutter_story_app/blocs/story/story_cubit.dart';
import 'package:flutter_story_app/blocs/story/story_state.dart';
import 'package:flutter_story_app/blocs/theme/theme_cubit.dart';
import 'package:flutter_story_app/pages/home_page.dart';
import 'package:flutter_story_app/pages/story_page.dart';
import 'package:flutter_story_app/pages/theme_selection_page.dart';
import 'package:flutter_story_app/repositories/auth_repository.dart';
import 'package:flutter_story_app/repositories/story_repository.dart';
import 'package:flutter_story_app/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _GuestAuth extends Fake implements AuthRepository {
  @override
  User? getCurrentUser() => null;
}

class _Translations extends AssetLoader {
  const _Translations();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async =>
      jsonDecode(
            File(
              '$path/${locale.languageCode}-${locale.countryCode}.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    for (final font in ['Lora', 'NunitoSans', 'Cinzel', 'MaterialIcons']) {
      await (FontLoader(font)..addFont(
        rootBundle.load(
          font == 'MaterialIcons'
              ? 'fonts/MaterialIcons-Regular.otf'
              : 'assets/fonts/$font.ttf',
        ),
      )).load();
    }
  });

  for (final locale in [const Locale('en', 'US'), const Locale('tr', 'TR')]) {
    for (final screen in ['home', 'selection', 'story', 'story-dark']) {
      testWidgets(
        'capture ${locale.languageCode} $screen',
        (tester) async {
          final dark = screen.endsWith('-dark');
          SharedPreferences.setMockInitialValues({
            'languageCode': locale.languageCode,
            'isDarkMode': dark,
          });
          tester.view.physicalSize = const Size(430, 1100);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final auth = AuthCubit(authRepository: _GuestAuth());
          final theme = ThemeCubit();
          final story = StoryCubit(
            storyRepository: StoryRepository(),
            languageCode: locale.languageCode,
          );
          if (screen.startsWith('story')) {
            await tester.runAsync(
              () => story.startNewStory(
                theme: 'theme_adventure',
                gender: 'gender_female',
              ),
            );
            expect(story.state, isA<StoryLoaded>());
            expect((story.state as StoryLoaded).isGuest, isTrue);
          }
          addTearDown(auth.close);
          addTearDown(theme.close);
          addTearDown(story.close);
          await tester.pumpWidget(
            EasyLocalization(
              key: ValueKey('${locale.languageCode}-$screen'),
              supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
              startLocale: locale,
              saveLocale: false,
              path: 'assets/langs',
              assetLoader: const _Translations(),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: auth),
                  BlocProvider.value(value: theme),
                  BlocProvider.value(value: story),
                ],
                child: ResponsiveSizer(
                  builder:
                      (context, orientation, screenType) => Builder(
                        builder:
                            (context) => RepaintBoundary(
                              key: const ValueKey('capture'),
                              child: MaterialApp(
                                debugShowCheckedModeBanner: false,
                                locale: context.locale,
                                supportedLocales: context.supportedLocales,
                                localizationsDelegates:
                                    context.localizationDelegates,
                                theme:
                                    dark
                                        ? AppTheme.darkTheme(context)
                                        : AppTheme.lightTheme(context),
                                home:
                                    screen == 'home'
                                        ? const HomePage()
                                        : screen == 'selection'
                                        ? ThemeSelectionPage(
                                          onSelectionDone: (_, _) {},
                                        )
                                        : const StoryPage(
                                          continueFromLast: true,
                                          theme: 'theme_adventure',
                                          gender: 'gender_female',
                                        ),
                              ),
                            ),
                      ),
                ),
              ),
            ),
          );
          await tester.pump();
          await tester.pump();
          if (screen == 'home') {
            await tester.runAsync(
              () => precacheImage(
                const AssetImage('assets/images/story-intro-gold.png'),
                tester.element(find.byType(HomePage)),
              ),
            );
          }
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          final boundary = tester.renderObject<RenderRepaintBoundary>(
            find.byKey(const ValueKey('capture')),
          );
          void repaint(RenderObject node) {
            node.markNeedsPaint();
            node.visitChildren(repaint);
          }

          repaint(boundary);
          await tester.pump();
          await tester.runAsync(() async {
            final image = await boundary.toImage(pixelRatio: 2);
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            File(
              'docs/store/screenshots/${locale.languageCode}-$screen.png',
            ).writeAsBytesSync(bytes!.buffer.asUint8List());
            image.dispose();
          });
        },
        skip: !const bool.fromEnvironment('CAPTURE_SCREENSHOTS'),
      );
    }
  }
}
