import 'package:auto_route/auto_route.dart';
import 'package:instx/futures/auth/signin/forget_password/view/forget_password.dart';

import '../futures/auth/auth_page.dart';

part 'router.gr.dart';

class AppRouterPath {
  static const signInRoutePath = '/signin';
  static const registrationRoutePath = '/registration';
  static const forgetPasswordRoutePath = '/signin/forget_password';
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthRoute.page,
          path: '/',
        ),
        AutoRoute(page: SignInRoute.page, path: AppRouterPath.signInRoutePath),
        AutoRoute(
            page: RegistrationRoute.page,
            path: AppRouterPath.registrationRoutePath),
        AutoRoute(
            page: ForgetPasswordRoute.page,
            path: AppRouterPath.forgetPasswordRoutePath)
      ];
}
