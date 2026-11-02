import 'package:flutter_story_app/widgets/brand_wordmark.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/blocs/auth/auth_cubit.dart';
import 'package:flutter_story_app/blocs/auth/auth_state.dart';
import 'package:flutter_story_app/blocs/story/story_cubit.dart';
import 'package:flutter_story_app/blocs/story/story_state.dart';
import 'package:flutter_story_app/pages/story_page.dart';
import 'package:flutter_story_app/pages/theme_selection_page.dart';
import 'package:flutter_story_app/widgets/app_scaffold.dart';
import 'package:flutter_story_app/widgets/primary_button.dart';
import 'package:flutter_story_app/widgets/auth_guard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<StoryCubit>().checkForSavedStory();
  }

  void _startStory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => AuthGuard(
              child: ThemeSelectionPage(
                onSelectionDone: (theme, gender) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => AuthGuard(
                            child: StoryPage(
                              continueFromLast: false,
                              theme: theme,
                              gender: gender,
                            ),
                          ),
                    ),
                  );
                },
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    titleWidget: const BrandWordmark(),
    body: LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 700;
        final artwork = ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Image.asset(
            'assets/images/story-intro-gold.png',
            width: double.infinity,
            height:
                wide ? 540 : (constraints.maxHeight * .45).clamp(220.0, 400.0),
            fit: BoxFit.cover,
            alignment: const Alignment(0, .25),
          ),
        );
        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'home_title'.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'story_intro_text'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            if (!wide) ...[artwork, const SizedBox(height: 20)],
            PrimaryButton(
              buttonText: 'start_story_button'.tr(),
              onPressed: _startStory,
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, auth) {
                if (auth is! AuthAuthenticated || auth.user.isAnonymous) {
                  return const SizedBox.shrink();
                }
                return BlocBuilder<StoryCubit, StoryState>(
                  builder: (context, story) {
                    if (story is! StoryLoaded || story.storyText.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        icon: const Icon(Icons.bookmark_outline),
                        label: Text('continue_story_button'.tr()),
                        onPressed:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => const AuthGuard(
                                      child: StoryPage(continueFromLast: true),
                                    ),
                              ),
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          child:
              wide
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: content),
                      const SizedBox(width: 36),
                      Expanded(child: artwork),
                    ],
                  )
                  : content,
        );
      },
    ),
  );
}
