import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexPage = 0;
  onPageChanged(int indexPage) {
    setState(() {
      _indexPage = indexPage;
    });
  }

  List<Widget> pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.orange,
    ),
    Container(
      color: Colors.green,
    )
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.secondary,
        onPressed: () {},
        child: const Icon(FontAwesomeIcons.plus),
      ),
      bottomNavigationBar: bottomNavigationBar(),
      appBar: AppBar(
        title: Text('Instx'),
      ),
      body: IndexedStack(
        index: _indexPage,
        children: pages,
      ),
      // drawer: SideDrawer(),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onPageChanged,
      unselectedItemColor: Colors.white,
      currentIndex: _indexPage,
      selectedItemColor: Colors.blue[500],
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell), label: 'Portfolio'),
      ],
    );
  }
}
