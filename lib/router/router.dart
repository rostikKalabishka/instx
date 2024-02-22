import 'package:auto_route/auto_route.dart';

import '../futures/auth/auth_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, path: '/', children: [
          AutoRoute(page: SignInRoute.page, path: '/signin'),
          AutoRoute(page: RegistrationRoute.page, path: '/registration')
        ]),
      ];
}
