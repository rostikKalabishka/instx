import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';
import 'package:instx/router/router.dart';
import 'package:instx/ui/theme/const.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.postModel});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).push(
                            ProfileRoute(userId: postModel.userModel.uid));
                      },
                      child: CircleAvatar(
                        backgroundImage: postModel.userModel.imageUrl.isNotEmpty
                            ? NetworkImage(postModel.userModel.imageUrl)
                            : const AssetImage(AppConst.userPlaceholder)
                                as ImageProvider<Object>,
                        radius: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AutoRouter.of(context).push(
                              ProfileRoute(userId: postModel.userModel.uid));
                        },
                        child: Text(
                          postModel.userModel.username,
                          style: theme.textTheme.subtitle1,
                        ),
                      ),
                      Text(
                        postModel.post,
                        style: theme.textTheme.bodyText1,
                      ),
                      const SizedBox(height: 10),
                      postModel.imageUrl.isNotEmpty
                          ? AspectRatio(
                              aspectRatio: 1.6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(postModel.imageUrl,
                                    fit: BoxFit.cover),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.heart,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(postModel.likeCount.toString(),
                                      style: theme.textTheme.subtitle1)
                                ],
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.marsStroke,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '2',
                                    style: theme.textTheme.subtitle1,
                                  )
                                ],
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.comment,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text('2', style: theme.textTheme.subtitle1)
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
