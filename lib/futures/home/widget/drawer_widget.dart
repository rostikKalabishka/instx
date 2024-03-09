import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/futures/auth/bloc/auth_bloc.dart';
import 'package:instx/router/router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              leading: const Icon(
                Icons.person,
                size: 30,
              ),
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                AutoRouter.of(context).push(
                  const ProfileRoute(),
                );
              },
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.payment,
            //     size: 30,
            //   ),
            //   title: const Text(
            //     'Twitter Blue',
            //     style: TextStyle(
            //       fontSize: 22,
            //     ),
            //   ),
            //   onTap: () {},
            // ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () async {
                context.read<AuthBloc>().add(LogOut());
                AutoRouter.of(context).pushAndPopUntil(const LoaderRoute(),
                    predicate: (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
