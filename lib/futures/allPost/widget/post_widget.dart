import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start, // Підняти вгору
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Підняти вгору
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(postModel.userModel.imageUrl),
                      radius: 20,
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
                      Text(
                        postModel.userModel.username,
                        style: theme.textTheme.subtitle1,
                      ),
                      Text(
                        postModel.post,
                        style: theme.textTheme.bodyText1,
                      ),
                      const SizedBox(height: 10),
                      postModel.imageUrl.isNotEmpty
                          ? AspectRatio(
                              aspectRatio:
                                  1.6, // Adjust this value to control the image's aspect ratio (width / height)
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    'https://t3.ftcdn.net/jpg/04/49/19/08/360_F_449190831_i2whvIQdDIGtuIVWT6QfenWwmRApVJ5l.jpg',
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
                              child: const Row(
                                children: [
                                  Icon(FontAwesomeIcons.heart),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('25')
                                ],
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Icon(FontAwesomeIcons.marsStroke),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('2')
                                ],
                              )),
                          TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Icon(FontAwesomeIcons.comment),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('2')
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
