import 'package:altcointrader/ui/screens/main_screen.dart';
import 'package:altcointrader/ui/screens/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  home('home'),
  profile('profile');

  const Routes(this.routeName);

  final String routeName;
}

class Navigation {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      return state.uri.toString();
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const MainHomeScreen()),
      GoRoute(path: '/${Routes.home.routeName}', name: Routes.home.routeName, builder: (context, state) => const MainHomeScreen()),
      GoRoute(path: '/${Routes.profile.routeName}', name: Routes.profile.routeName, builder: (context, state) => const ProfileScreen()),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Route Error')),
      body: Center(child: Text("This path doesn't exist: ${state.uri.toString()}")),
    ),
  );

  static void showHomeScreen(BuildContext context) {
    HapticFeedback.heavyImpact();
    context.goNamed(Routes.home.routeName);
  }
}
