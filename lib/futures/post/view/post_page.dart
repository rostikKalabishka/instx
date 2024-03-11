import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/futures/post/bloc/post_bloc.dart';
import 'package:instx/router/router.dart';
import 'package:instx/ui/theme/const.dart';

@RoutePage()
class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final postController = TextEditingController();
  bool _isPanelAbove = false;

  @override
  void initState() {
    context.read<PostBloc>().add(LoadInfoEvent(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: theme.scaffoldBackgroundColor,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<PostBloc>().add(CreatePostEvent(
                                  userId: widget.userId,
                                  post: postController.text,
                                  imageUrl: state.imagePost));
                              AutoRouter.of(context).push(const HomeRoute());
                            },
                            child: const Text('Publish'),
                          ),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    backgroundImage: state
                                            .userModel.imageUrl.isNotEmpty
                                        ? NetworkImage(state.userModel.imageUrl)
                                        : const AssetImage(
                                                AppConst.userPlaceholder)
                                            as ImageProvider<Object>,
                                    radius: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.83,
                                      child: TextFormField(
                                        controller: postController,
                                        decoration: const InputDecoration(
                                          hintText: 'Create post',
                                          border: InputBorder.none,
                                        ),
                                        autofocus: false,
                                        minLines: 1,
                                        maxLines: 30,
                                        onTap: () {
                                          setState(() {
                                            _isPanelAbove = true;
                                          });
                                        },
                                        onEditingComplete: () {
                                          setState(() {
                                            _isPanelAbove = false;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    state.imagePost.isNotEmpty
                                        ? Image.asset(state.imagePost)
                                        : const SizedBox.shrink()
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom:
                      _isPanelAbove ? MediaQuery.of(context).viewInsets.top : 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.3,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0).copyWith(
                            left: 15,
                            right: 15,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.read<PostBloc>().add(SelectImageEvent(
                                  imageQuality: 40,
                                  maxWidth: 500,
                                  maxHeight: 500,
                                  toolbarWidgetColor: Colors.white,
                                  toolbarColor: theme.colorScheme.primary));
                            },
                            child: const Icon(Icons.attachment_rounded),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0).copyWith(
                            left: 15,
                            right: 15,
                          ),
                          child: const Icon(FontAwesomeIcons.glassWaterDroplet),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0).copyWith(
                            left: 15,
                            right: 15,
                          ),
                          child: const Icon(FontAwesomeIcons.glassWaterDroplet),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
