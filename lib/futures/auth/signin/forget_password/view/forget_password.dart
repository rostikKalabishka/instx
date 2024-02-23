import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:instx/ui/components/custom_text_field.dart';

@RoutePage()
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue),
              ),
              onTap: () {},
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text('Create account'))
          ],
        ),
      ),
    );
  }
}
