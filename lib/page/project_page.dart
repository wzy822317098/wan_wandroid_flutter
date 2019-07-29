import 'package:flutter/material.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';
import 'package:wan_wandroid/network/network_utils.dart';
import 'package:wan_wandroid/model/project_category_model.dart';
import 'package:wan_wandroid/widgets/frag_project_articles.dart';

///@description
///
///@created by wangzhouyao on 2019-07-29
class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Widget> _projectCategory;
  List<Widget> _articlePages = List();
  TabController _controller;
  @override
  void initState() {
    super.initState();
    NetworkUtils.instance.getProjectCategory().then((data) {
      setState(() {
        _projectCategory = List();
        data.data.forEach((it) {
          _projectCategory.add(Tab(
            text: it.name,
          ));
          _articlePages.add(FragProjectArticles(it));
        });
        _controller = TabController(length: _articlePages.length, vsync: this);
        _controller.addListener(() {
          switch (_controller.index) {
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.color_bg,
      appBar: AppBar(
        title: _projectCategory != null
            ? TabBar(
                isScrollable: true,
                tabs: _projectCategory,
                controller: _controller,
              )
            : Container(),
      ),
      body: _controller != null
          ? TabBarView(
              children: _articlePages,
              controller: _controller,
            )
          : Container(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
