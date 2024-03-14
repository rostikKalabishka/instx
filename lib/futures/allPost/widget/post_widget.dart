import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/futures/allPost/local_entity/local_entity_post.dart';
import 'package:instx/router/router.dart';
import 'package:instx/ui/theme/const.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
      {super.key, required this.localEntityPost, required this.onPressed});
  final LocalEntityPost localEntityPost;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                      AutoRouter.of(context).push(ProfileRoute(
                          userId: localEntityPost.postModel.userModel.uid));
                    },
                    child: CircleAvatar(
                      backgroundImage: localEntityPost
                              .postModel.userModel.imageUrl.isNotEmpty
                          ? NetworkImage(
                              localEntityPost.postModel.userModel.imageUrl)
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
                        AutoRouter.of(context).push(ProfileRoute(
                            userId: localEntityPost.postModel.userModel.uid));
                      },
                      child: Text(
                        localEntityPost.postModel.userModel.username,
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
                    Text(
                      localEntityPost.postModel.post,
                      style: theme.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 10),
                    localEntityPost.postModel.imageUrlList.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: localEntityPost
                                          .postModel.imageUrlList.length ==
                                      1
                                  ? 1
                                  : 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                            ),
                            itemCount:
                                localEntityPost.postModel.imageUrlList.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  localEntityPost.postModel.imageUrlList[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: onPressed,
                          child: Row(
                            children: [
                              localEntityPost.isLiked
                                  ? const Icon(
                                      FontAwesomeIcons.heartCircleCheck,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.heart,
                                      color: theme.colorScheme.secondary,
                                    ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                localEntityPost.likeCounter.toString(),
                                style: theme.textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
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
                                '0',
                                style: theme.textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
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
                              Text(
                                localEntityPost.commentCounter.toString(),
                                style: theme.textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
