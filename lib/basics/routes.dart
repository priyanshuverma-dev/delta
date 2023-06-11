import 'package:answer_it/basics/credits_screen.dart';
import 'package:answer_it/basics/feedback_screen.dart';
import 'package:answer_it/basics/splash_screen.dart';
import 'package:answer_it/features/Chat/view/chat_screen.dart';
import 'package:answer_it/screens/home_screen.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/',
        page: () => const SplashScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/home',
        page: () => const HomeScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/chat',
        page: () => ChatScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/credits',
        page: () => const CreditsScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/feedback',
        page: () => const FeedBackScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 250),
      ),
    ];
