import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/ui/theme/const.dart';

class CommentListWidget extends StatefulWidget {
  const CommentListWidget({super.key});

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          // backgroundImage: localEntityPost
                          //         .postModel.userModel.imageUrl.isNotEmpty
                          //     ? NetworkImage(
                          //         localEntityPost.postModel.userModel.imageUrl)
                          //:
                          backgroundImage: AssetImage(AppConst.userPlaceholder)
                              as ImageProvider<Object>,
                          radius: 20,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Vvvvvv dssfddfs',
                                style: theme.textTheme.subtitle1,
                              ),
                              Text(
                                '14 aug 2002 15:30',
                                style: theme.textTheme.bodySmall,
                              ),
                            ]),
                        Text(
                          'Vvvvvv dssfddfs ddddddddddd dddddd ddddd',
                          style: theme.textTheme.bodyText1,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Add comment',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.secondary)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.arrowRight))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
