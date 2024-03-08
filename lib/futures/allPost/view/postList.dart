import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instx/futures/allPost/widget/post_widget.dart';
import 'package:instx/router/router.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final userId = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: theme.colorScheme.secondary,
        onPressed: () async {
          AutoRouter.of(context).push(PostRoute(userId: userId));
        },
        child: Icon(
          FontAwesomeIcons.plus,
          color: theme.iconTheme.color,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const PostWidget();
              })
        ],
      ),
    );
  }
}
