// 📦 Package imports:
import 'package:app_mobile/presentation/pages/dashboard/pages/base.dart';
import 'package:app_mobile/presentation/pages/game_map/game_map_screen.dart';
import 'package:app_mobile/presentation/pages/home/home_center.dart';
import 'package:app_mobile/presentation/pages/leaderboard/leaderboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_mobile/presentation/pages/profile/profile.dart';

// 🌎 Project imports:
import '../pages/pages.dart';

abstract class AcnooAppRoutes {
  static final _appNavigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navKey => _appNavigatorKey;
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static const _initialPath = '/';
  static GoRouter buildRouter() {
    return GoRouter(
      navigatorKey: _appNavigatorKey,
      initialLocation: _initialPath,
      // redirect: (context, state) {
      //   final onAuth = state.matchedLocation.startsWith('/authentication');
      //   final hasToken =
      //       SharedPreferencesProvider.instance.accessToken.isNotEmpty;

      //   if (!hasToken && !onAuth) {
      //     return '/authentication/signin';
      //   }

      //   return null;
      // },
      routes: [
        // Landing Route Handler
        GoRoute(
          path: _initialPath,
          redirect: (context, state) {
            // if (SharedPreferencesProvider.instance.accessToken.isEmpty) {
            //   return '/authentication/signin';
            // }
            // final _appLangProvider =
            //     Provider.of<AppProvider>(context, listen: false);
            // if (state.uri.queryParameters['rtl'] == 'true') {
            //   _appLangProvider.isRTL = true;
            // }
            return '/home_center';
          },
        ),

        // Global Shell Route
        ShellRoute(
          navigatorKey: rootNavigatorKey,
          pageBuilder: (context, state, child) {
            return NoTransitionPage(
              child: ShellRouteWrapper(child: child),
            );
          },
          routes: [
            // Dashboard Routes
            GoRoute(
              path: '/dashboard',
              redirect: (context, state) async {
                if (state.fullPath == '/dashboard') {
                  return '/dashboard/base';
                }
                return null;
              },
              routes: [
                GoRoute(
                  path: 'base',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: DashboardBaseView(),
                  ),
                ),
              ],
            ),

            //--------------Application Section--------------//
            GoRoute(
              path: '/calendar',
              pageBuilder: (context, state) => const NoTransitionPage<void>(
                child: CalendarView(),
              ),
            ),
            GoRoute(
              path: '/users/user-profile',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Profile(),
              ),
            ),
          ],
        ),

        // Full Screen Pages

        GoRoute(
          path: '/authentication',
          redirect: (context, state) async {
            if (state.fullPath == '/authentication') {
              return '/authentication/signin';
            }
            return null;
          },
          routes: [
            // GoRoute(
            //   path: 'signup',
            //   pageBuilder: (context, state) => const NoTransitionPage(
            //     child: SignupView(),
            //   ),
            // ),
            // GoRoute(
            //   path: 'signin',
            //   pageBuilder: (context, state) => const NoTransitionPage(
            //     child: SigninView(),
            //   ),
            // ),
          ],
        ),
        GoRoute(
          path: '/home_center',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeCenter(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Profile(),
          ),
        ),
        GoRoute(
          path: '/game_map',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: GameMapScreen(),
          ),
        ),
        GoRoute(
          path: '/leader_board',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: LeaderboardScreen(),
          ),
        ),
      ],
      errorPageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundView(),
      ),
    );
  }
}
