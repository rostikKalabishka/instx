import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/domain/repositories/comment_repository/models/comment_model.dart';
import 'package:instx/domain/repositories/post_repository/models/post_model.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';
import 'package:instx/futures/auth/bloc/auth_bloc.dart';
import 'package:instx/ui/theme/const.dart';
import 'package:intl/intl.dart';

class CommentListWidget extends StatefulWidget {
  const CommentListWidget(
      {super.key, required this.commentList, required this.postModel});
  final List<CommentModel> commentList;
  final PostModel postModel;

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  final TextEditingController commentController = TextEditingController();
  late List<CommentModel> commentList;
  @override
  void initState() {
    commentList = widget.commentList;
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
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: commentList.length,
            itemBuilder: (context, index) {
              final comment = commentList[index];
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
                                comment.postModel.userModel.username,
                                style: theme.textTheme.subtitle1,
                              ),
                              Text(
                                DateFormat.yMd()
                                    .add_jm()
                                    .format(comment.createAt),
                                style: theme.textTheme.bodySmall,
                              ),
                            ]),
                        Text(
                          comment.comment,
                          style: theme.textTheme.bodyText1,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
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
                        controller: commentController,
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
                          onPressed: () {
                            context.read<AllPostBloc>().add(
                                  AddComment(
                                      comment: commentController.text,
                                      userId:
                                          context.read<AuthBloc>().state.userId,
                                      postModel: widget.postModel),
                                );
                            setState(() {});
                          },
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
