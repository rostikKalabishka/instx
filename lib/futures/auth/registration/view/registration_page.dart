import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/futures/auth/registration/bloc/registration_bloc.dart';
import 'package:instx/ui/components/custom_text_field.dart';

@RoutePage()
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final usernameTextController = TextEditingController();

  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  bool isActiveButton = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {},
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
                    'Create profile',
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
                          'Create account',
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
                          controller: usernameTextController,
                          hintText: 'username',
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<RegistrationBloc>().add(RegistrationEvent(
                            email: emailTextController.text,
                            password: passwordTextController.text,
                            userName: usernameTextController.text,
                            context: context));
                      },
                      // isActiveButton ? () {} : null,
                      child: const Text('Create'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
