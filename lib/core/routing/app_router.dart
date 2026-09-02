import 'package:go_router/go_router.dart';

import '../../screens/about/about_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/quiz/quiz_result_screen.dart';
import '../../screens/quiz/quiz_screen.dart';
import '../../screens/security/security_detail_screen.dart';
import '../../screens/security/security_list_screen.dart';
import '../../screens/tutorials/tutorial_detail_screen.dart';
import '../../screens/tutorials/tutorial_list_screen.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/tutoriais',
      builder: (context, state) => const TutorialListScreen(),
    ),
    GoRoute(
      path: '/tutoriais/:id',
      builder: (context, state) =>
          TutorialDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/seguranca',
      builder: (context, state) => const SecurityListScreen(),
    ),
    GoRoute(
      path: '/seguranca/:id',
      builder: (context, state) =>
          SecurityDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/quiz',
      builder: (context, state) => const QuizScreen(),
    ),
    GoRoute(
      path: '/quiz/resultado',
      builder: (context, state) => const QuizResultScreen(),
    ),
    GoRoute(
      path: '/sobre',
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);
