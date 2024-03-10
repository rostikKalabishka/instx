import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';
import 'package:instx/futures/allPost/widget/post_widget.dart';
import 'package:instx/futures/profile/bloc/profile_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userId});
  final String userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadedInfo(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.statusPage == StatusPage.loaded) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://t3.ftcdn.net/jpg/04/49/19/08/360_F_449190831_i2whvIQdDIGtuIVWT6QfenWwmRApVJ5l.jpg'),
                              radius: 30,
                            ),
                            OutlinedButton(
                                onPressed: () {}, child: Text('data ads'))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.userModel.username,
                          style: theme.textTheme.displaySmall,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.userModel.email,
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'zxc zxxc dasdasd dasda sd dasdsadsa d sadasdasdasd',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Create account',
                              style: theme.textTheme.labelLarge,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              FontAwesomeIcons.calendar,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              state.userModel.createAt,
                              style: theme.textTheme.labelLarge,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                ),
                SliverList.separated(
                  itemCount: state.postList.length,
                  itemBuilder: ((context, index) {
                    final post = state.postList[index];
                    return PostWidget(
                      postModel: post,
                    );
                  }),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                )
              ],
            ),
          );
        } else if (state.statusPage == StatusPage.failure) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text(state.error.toString()),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        context.read<AllPostBloc>().add(AllPostLoaded());
                      },
                      child: const Text('Reload'))
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }
}
