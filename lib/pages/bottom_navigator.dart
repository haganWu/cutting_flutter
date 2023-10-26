import 'package:cutting_flutter/pages/shopping_page.dart';
import 'package:flutter/material.dart';
import 'community_page.dart';
import 'home_page.dart';
import 'my_page.dart';

/// 首页底部导航
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  final defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 更新导航器上下文context
    // NavigatorUtil.updateContext(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        // 禁止PageView左右滑动
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          CommunityPage(),
          ShoppingPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,

          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          //将label固定
          unselectedItemColor: defaultColor,
          selectedItemColor: _activeColor,
          items: [
            _bottomItem(title: '首页', icon: Icons.home_outlined, index: 0),
            _bottomItem(title: '社区', icon: Icons.keyboard_command_key_outlined, index: 1),
            _bottomItem(title: '商城', icon: Icons.shopping_bag_outlined, index: 2),
            _bottomItem(title: '我的', icon: Icons.account_box_outlined, index: 3),
          ],
        ),
      ),
    );
  }

  _bottomItem({required String title, required IconData icon, required int index}) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }
}
