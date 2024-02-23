import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instx/futures/auth/bloc/auth_bloc.dart';

import 'package:instx/ui/components/components.dart';
import 'package:instx/ui/theme/const.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double buttonHeight = MediaQuery.of(context).size.height * 0.05;
    final double buttonWidth = MediaQuery.of(context).size.height * 0.9;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: Text(
                  'InstX',
                  style: theme.textTheme.displayLarge,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.1,
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    'Find out what\'s happening in the world right now',
                    style: theme.textTheme.displayMedium,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  child: CustomButtonRegistration(
                      onTap: () {},
                      height: buttonHeight,
                      width: buttonWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 2 / 3,
                            child: SvgPicture.asset(
                              AppConst.googleSvg,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign in with your google profile',
                            maxLines: 1,
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  child: CustomButtonRegistration(
                      height: buttonHeight,
                      width: buttonWidth,
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 2 / 3,
                            child: SvgPicture.asset(
                              AppConst.appleSvg,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign in with your apple profile',
                            maxLines: 1,
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02,
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: theme.dividerColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'OR',
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: theme.dividerColor,
                          ),
                        ),
                      ],
                    )),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: CustomButtonRegistration(
                    onTap: () {
                      context
                          .read<AuthBloc>()
                          .add(NavigateToRegistration(context: context));
                    },
                    height: buttonHeight,
                    width: buttonWidth,
                    child: Text(
                      'Create profile',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Row(
                      children: [
                        Text('Do you already have a profile?',
                            style: theme.textTheme.bodySmall),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          child: Text(
                            'Sign in',
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: Colors.blue),
                          ),
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(NavigateToSignIn(context: context));
                          },
                        )
                      ],
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
