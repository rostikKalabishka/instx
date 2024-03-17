import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:instx/futures/auth/signin/forget_password/view/forget_password.dart';
import 'package:instx/futures/followers_page/view/followers_page.dart';
import 'package:instx/futures/loader/view/loader.dart';
import 'package:instx/futures/post/view/post_page.dart';
import 'package:instx/futures/profile/view/profile_page.dart';

import '../futures/auth/auth_page.dart';
import '../futures/home/home_page.dart';

part 'router.gr.dart';

class AppRouterPath {
  static const signInRoutePath = '/signin';
  static const registrationRoutePath = '/registration';
  static const forgetPasswordRoutePath = '/signin/forget_password';
  static const homeRoutePath = '/home';
  static const authRoutePath = '/auth';
  static const postRoutePath = '/home/post';
  static const profileRoutePath = '/home/profile';
  static const followersRoutePath = '/home/profile/followers';
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoaderRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: AuthRoute.page,
          path: AppRouterPath.authRoutePath,
        ),
        AutoRoute(page: SignInRoute.page, path: AppRouterPath.signInRoutePath),
        AutoRoute(
            page: RegistrationRoute.page,
            path: AppRouterPath.registrationRoutePath),
        AutoRoute(
            page: ForgetPasswordRoute.page,
            path: AppRouterPath.forgetPasswordRoutePath),
        AutoRoute(page: HomeRoute.page, path: AppRouterPath.homeRoutePath),
        AutoRoute(page: PostRoute.page, path: AppRouterPath.postRoutePath),
        AutoRoute(
            page: ProfileRoute.page, path: AppRouterPath.profileRoutePath),
        AutoRoute(
            page: FollowersRoute.page, path: AppRouterPath.followersRoutePath),
      ];
}
