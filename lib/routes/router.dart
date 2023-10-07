import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eCommSuit/components/Navigation/navigationNested.dart';
import 'package:eCommSuit/components/Screen/rootScreen.dart';
import 'package:eCommSuit/components/Screen/categoriesScreen.dart';
import 'package:eCommSuit/components/Screen/subcategoriesScreen.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
final _shellNavigatorCategoriesKey =
    GlobalKey<NavigatorState>(debugLabel: 'Categories');

final goRouter = GoRouter(
  initialLocation: '/',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          // Set a default location without parameters
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(label: 'My Home 2'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCategoriesKey,
          // Set a default location without parameters
          routes: [
            GoRoute(
              path: '/categories',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CategoriesScreen(label: 'Categories'),
              ),
              routes: [
                GoRoute(
                  path: ':parentId/:categoryId',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return NoTransitionPage(
                      child: SubcategoriesScreen(
                        // categoryName: state.pathParameters['categoryName'],
                        // subcategoryName: state.pathParameters['subcategoryName'],
                        categoryId: state.pathParameters['categoryId'],
                        parentId: state.pathParameters['parentId'],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
