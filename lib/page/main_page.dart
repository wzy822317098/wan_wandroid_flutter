import 'package:flutter/material.dart';
import 'home_page.dart';
import 'system_page.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

///@description 承载首页4个tab的主页
///
///@created by wangzhouyao on 2019-07-10
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _selectIndex = 0;

  final List<Widget> _tabList = <Widget>[
    new HomePage(),
    new SystemPage(),
    new HomePage(),
    new SystemPage()
  ];

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView.builder(
          onPageChanged: _onItemTapped,
          controller: _pageController,
          itemCount: _tabList.length,
          itemBuilder: (BuildContext context, int index) {
            return _tabList[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), title: Text('体系')),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), title: Text('公众号')),
          BottomNavigationBarItem(icon: Icon(Icons.folder_open), title: Text('项目'))
        ],
        fixedColor: ColorsUtils.color_title,
        unselectedItemColor: ColorsUtils.color_content,
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
    _pageController.jumpToPage(index);
  }
}
