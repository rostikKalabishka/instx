import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instx/futures/followers_page/bloc/followers_page_bloc.dart';
import 'package:instx/ui/theme/const.dart';

@RoutePage()
class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key, required this.userId});
  final String userId;

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  void initState() {
    context
        .read<FollowersPageBloc>()
        .add(LoadAllFollowers(userId: widget.userId));
    super.initState();
  }

  final searchCoinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<FollowersPageBloc, FollowersPageState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(
                        MediaQuery.of(context).size.height * 0.0865),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 8)
                          .copyWith(bottom: 12),
                      padding: const EdgeInsets.all(1),
                      child: TextFormField(
                        controller: searchCoinController,
                        onChanged: (text) {
                          if (text.isEmpty) {
                            context
                                .read<FollowersPageBloc>()
                                .add(LoadAllFollowers(userId: widget.userId));
                          } else if (text.isNotEmpty) {
                            context.read<FollowersPageBloc>().add(
                                SearchFollowersEvent(
                                    text: searchCoinController.text,
                                    userId: widget.userId));
                          }
                        },
                        style: theme.textTheme.bodySmall,
                        decoration: InputDecoration(
                            hintText: 'Search for a coin...',
                            hintStyle: TextStyle(color: theme.hintColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                ),
                SliverList.separated(
                    itemCount: state.userModelList.length,
                    itemBuilder: (context, index) {
                      final user = state.userModelList[index];
                      return ListTile(
                          title: Text(user.imageUrl),
                          subtitle: Text(user.status),
                          leading: CircleAvatar(
                            backgroundImage: user.imageUrl.isNotEmpty
                                ? NetworkImage(user.imageUrl)
                                : const AssetImage(AppConst.userPlaceholder)
                                    as ImageProvider<Object>,
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
