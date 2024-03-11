import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/futures/allPost/bloc/all_post_bloc.dart';
import 'package:instx/futures/allPost/widget/post_widget.dart';
import 'package:instx/futures/auth/bloc/auth_bloc.dart';
import 'package:instx/router/router.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  void initState() {
    context.read<AllPostBloc>().add(AllPostLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AllPostBloc, AllPostState>(
      builder: (context, state) {
        if (state.status == StatusPage.loaded) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<AllPostBloc>().add(AllPostLoaded());
            },
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: theme.colorScheme.secondary,
                onPressed: () async {
                  AutoRouter.of(context).push(
                      PostRoute(userId: context.read<AuthBloc>().state.userId));
                },
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: theme.iconTheme.color,
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverList.separated(
                    itemCount: state.postList.length,
                    itemBuilder: (context, index) {
                      final post = state.postList[index];
                      return PostWidget(
                        postModel: post,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  )
                ],
              ),
            ),
          );
        } else if (state.status == StatusPage.failure) {
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
