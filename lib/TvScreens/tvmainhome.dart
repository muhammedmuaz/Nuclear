import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

class TvMainScreen extends StatefulWidget {
  @override
  _TvMainScreenState createState() => _TvMainScreenState();
}

class _TvMainScreenState extends State<TvMainScreen> {
  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('assets/logo2.gif');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'GeeksforGeeks',
        icon: Icons.search_outlined,
        onPressed: () => setState(() => _headline = 'Geeks For Geeks'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Flutter',
        icon: Icons.flutter_dash_outlined,
        onPressed: () => setState(() => _headline = 'Flutter'),
      ),
      CollapsibleItem(
        text: 'HTML',
        icon: Icons.html_outlined,
        onPressed: () => setState(() => _headline = 'HTML'),
      ),
      CollapsibleItem(
        text: 'CSS',
        icon: Icons.css_outlined,
        onPressed: () => setState(() => _headline = 'CSS'),
      ),
      CollapsibleItem(
        text: 'JavaScript',
        icon: Icons.javascript_outlined,
        onPressed: () => setState(() => _headline = 'JavaScript'),
      ),
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState(() => _headline = 'Home'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        borderRadius: 0,
        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: _items,
        avatarImg: _avatarImg,
        title: 'MS471841',
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(size, context),
        selectedIconBox: Colors.transparent,
        unselectedTextColor: Colors.white,
        unselectedIconColor: Colors.white,
        backgroundColor: const Color(0xff707070),
        selectedIconColor: Colors.orangeAccent,
        selectedTextColor: Colors.orangeAccent,
        textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 20,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 50,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: backgroundColor,
      child: Center(
        child: Text(
          _headline,
          style: Theme.of(context).textTheme.headline2,
          overflow: TextOverflow.visible,
          softWrap: false,
        ),
      ),
    );
  }
}
