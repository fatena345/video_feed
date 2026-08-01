import 'package:flutter/material.dart';
import 'package:tiktok/core/utils/enum/enum_utils.dart';
import 'package:tiktok/presentation/screens/splash/splash_screen.dart';
import '../extension/page_builder_extension.dart';
import '../../presentation/screens/video_feed/video_feed_screen.dart';
import 'package:go_router/go_router.dart';
part 'app_routes.g.dart';

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  CustomTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return const SplashScreen().buildPage(pageAnimation: PageAnimation.fade);
  }
}

@TypedGoRoute<VideoFeedRoute>(path: '/feed')
class VideoFeedRoute extends GoRouteData with $VideoFeedRoute {
  const VideoFeedRoute();

  @override
  CustomTransitionPage<void> buildPage(BuildContext context, GoRouterState state) {
    return const VideoFeedScreen().buildPage(pageAnimation: PageAnimation.slide);
  }
}