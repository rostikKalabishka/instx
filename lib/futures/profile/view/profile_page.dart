import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/futures/allPost/widget/post_widget.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(12),
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
                      OutlinedButton(onPressed: () {}, child: Text('data ads'))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'zxc zxxc',
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '@zxczxxc',
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
                        'april 21 2002',
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
            itemCount: 10,
            itemBuilder: ((context, index) {
              return const PostWidget();
            }),
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              );
            },
          )
        ],
      ),
    );
  }
}
