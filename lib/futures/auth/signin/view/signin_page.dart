import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/futures/auth/signin/bloc/sign_in_bloc.dart';

import 'package:instx/ui/components/custom_text_field.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in to your account',
                          style: theme.textTheme.displaySmall,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: emailTextController,
                          hintText: 'email',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: passwordTextController,
                          hintText: 'password',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: theme.scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Text(
                      'Forget password?',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.blue),
                    ),
                    onTap: () {
                      context.read<SignInBloc>().add(
                          NavigateToForgetPasswordPageEvent(context: context));
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(LoginEvent(
                            context: context,
                            email: emailTextController.text,
                            password: passwordTextController.text));
                      },
                      child: const Text('Next'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
