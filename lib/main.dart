import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'core/services/locator/locator.dart';
import 'core/routes/app_routes.dart';
import 'presentation/bloc/video_feed/video_feed_bloc.dart';
import 'presentation/bloc/video_feed/video_feed_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: "key.env");
  } catch (_) {
    debugPrint(".env missing: API key was not loaded");
  }

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: $appRoutes,
    );

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<VideoFeedBloc>(
          create: (context) => locator<VideoFeedBloc>()..add(const FetchVideosEvent(query: 'nature')),
          child: MaterialApp.router(
            title: 'TikTok Style Video Feed',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.indigo,
            ),
            routerConfig: router,
          ),
        );
      },
    );
  }
}