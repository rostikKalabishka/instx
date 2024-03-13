import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';
import 'package:instx/futures/allPost/widget/post_widget.dart';
import 'package:instx/futures/auth/bloc/auth_bloc.dart';
import 'package:instx/futures/profile/bloc/profile_bloc.dart';
import 'package:instx/ui/components/show_modal_menu_bottom_sheet.dart';
import 'package:instx/ui/theme/const.dart';

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
                            CircleAvatar(
                              backgroundImage: state
                                      .userModel.imageUrl.isNotEmpty
                                  ? NetworkImage(state.userModel.imageUrl)
                                  : const AssetImage(AppConst.userPlaceholder)
                                      as ImageProvider<Object>,
                              radius: 30,
                            ),
                            context.read<AuthBloc>().state.userId ==
                                    widget.userId
                                ? OutlinedButton(
                                    onPressed: () async {
                                      await showModalMenuBottomSheet(
                                          context: context,
                                          modalHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          child: UpdateUserInfoWidget(
                                            state: state,
                                          ));
                                    },
                                    child: Text(
                                      'Redact Profile',
                                      style: theme.textTheme.labelLarge,
                                    ))
                                : const SizedBox.shrink()
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
                          state.userModel.status.isNotEmpty
                              ? state.userModel.status
                              : 'No have status',
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
                              state.userModel.createAt.toString(),
                              style: theme.textTheme.labelLarge,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Followers: ${state.userModel.followers.length}',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                ),
                state.postList.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'This user doesn`t have any post',
                              style: theme.textTheme.displaySmall,
                            ),
                          ),
                        ),
                      )
                    : SliverList.separated(
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

class UpdateUserInfoWidget extends StatefulWidget {
  const UpdateUserInfoWidget({
    Key? key,
    required this.state,
  }) : super(key: key);
  final ProfileState state;

  @override
  State<UpdateUserInfoWidget> createState() => _UpdateUserInfoWidgetState();
}

class _UpdateUserInfoWidgetState extends State<UpdateUserInfoWidget> {
  late TextEditingController userNameController;
  late TextEditingController statusController;
  bool isVisibleButton = false;
  String newImage = '';

  @override
  void initState() {
    userNameController =
        TextEditingController(text: widget.state.userModel.username);
    statusController =
        TextEditingController(text: widget.state.userModel.status);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final theme = Theme.of(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        setState(() {
          newImage = state.newImage;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: GestureDetector(
                      child: Text(
                        'Cancel',
                        style: theme.textTheme.titleSmall,
                      ),
                      onTap: () {
                        AutoRouter.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text('Redact Profile',
                        style: theme.textTheme.headlineSmall),
                  ),
                  isVisibleButton
                      ? Expanded(
                          child: GestureDetector(
                            child: Text('Update',
                                style: theme.textTheme.titleSmall),
                            onTap: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(UpdateUserInfoEvent(
                                    updateUserName: userNameController.text,
                                    updateStatus: statusController.text,
                                    context: context,
                                  ));
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  context.read<ProfileBloc>().add(
                        SelectImageEvent(
                          imageUrl: state.newImage,
                          maxHeight: 500,
                          maxWidth: 500,
                          imageQuality: 40,
                          toolbarWidgetColor: Colors.white,
                          toolbarColor: theme.colorScheme.primary,
                        ),
                      );
                },
                child: CircleAvatar(
                  backgroundImage: newImage.isEmpty
                      ? state.userModel.imageUrl.isNotEmpty
                          ? NetworkImage(state.userModel.imageUrl)
                          : const AssetImage(AppConst.userPlaceholder)
                              as ImageProvider<Object>
                      : AssetImage(newImage),
                  radius: 30,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Divider(),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      'Username',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        if (state.userModel.username != value) {
                          setState(() {
                            isVisibleButton = true;
                          });
                        }
                      },
                      controller: userNameController,
                      decoration: const InputDecoration(
                        hintText: 'Create post',
                        border: InputBorder.none,
                      ),
                      autofocus: false,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text('Status', style: theme.textTheme.titleSmall),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        if (state.userModel.status != value) {
                          setState(() {
                            isVisibleButton = true;
                          });
                        }
                      },
                      controller: statusController,
                      decoration: const InputDecoration(
                        hintText: 'Create post',
                        border: InputBorder.none,
                      ),
                      autofocus: false,
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
