import 'package:answer_it/basics/credits_screen.dart';
import 'package:answer_it/basics/feedback_screen.dart';
import 'package:answer_it/basics/splash_screen.dart';
import 'package:answer_it/features/Chat/view/chat_screen.dart';
import 'package:answer_it/features/Chat/view/history_screen.dart';
import 'package:answer_it/screens/home_screen.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/',
        page: () => SplashScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/chat',
        page: () => ChatScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/history',
        page: () => HistoryScreen(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/credits',
        page: () => CreditsScreen(),
        transition: Transition.downToUp,
        transitionDuration: Duration(milliseconds: 250),
      ),
      GetPage(
        name: '/feedback',
        page: () => FeedBackScreen(),
        transition: Transition.downToUp,
        transitionDuration: Duration(milliseconds: 250),
      ),
    ];
