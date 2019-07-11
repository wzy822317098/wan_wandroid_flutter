import 'package:flutter/material.dart';
import 'package:wan_wandroid/network/NetworkUtil.dart';
import 'package:wan_wandroid/utils/shared_preferences_utils.dart';
import 'package:wan_wandroid/utils/dialog_utils.dart';
import 'package:wan_wandroid/page/search_result_page.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<SearchPage> {
  final _controller = TextEditingController();
  final _hotKeyWidgets = List<GestureDetector>();
  final _searchKeyHistory = List<String>();

  @override
  void initState() {
    super.initState();
    _getHotKey();
    _getSearchKeyHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.color_bg,
      appBar: AppBar(
        leading: BackButton(color: ColorsUtils.color_title,),
        title: TextField(
          controller: _controller,
          style: TextStyle(
            fontSize: 14,
            color: ColorsUtils.color_title
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: '用空格隔开多个关键字',
            hintStyle: TextStyle(fontSize: 14),
            filled: true,
//              border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(10.0),
//                  borderSide: BorderSide(color: Colors.blueGrey[300]))
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,color: ColorsUtils.color_title,),
            onPressed: _doSearch,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(9),
            child: Text("热门搜索"),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: _hotKeyWidgets,
            ),
          ),
          _searchKeyHistory.length > 0
              ? Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('历史记录'),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '清除所有',
                            style: TextStyle(color: Colors.red[300]),
                          ),
                        ),
                        onTap: _clearHistory,
                      )
                    ],
                  ),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.all(8),
            child: _searchKeyHistory.length > 0
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext contenxt, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.only(left: 0, right: 0),
                        title: Text(
                          _searchKeyHistory[index],
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              _removeSearchHistory(index);
                            }),
                        onTap: () {
                          _controller.text = _searchKeyHistory[index];
                          _doSearch();
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(height: 8,),
                    itemCount: _searchKeyHistory.length)
                : Container(),
          )
        ],
      ),
    );
  }

  void _getHotKey() {
    NetworkUtils.instance.getHotKey().then((data) {
      setState(() {
        data.forEach((it) {
          _hotKeyWidgets.add(GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey[300],
              child: Text(it.name),
            ),
            onTap: () {
              setState(() {
                _controller.text = it.name;
                _doSearch();
              });
            },
          ));
        });
      });
    });
  }

  void _getSearchKeyHistory() {
    SharedPreferencsUtils.getInstance()
        .getSytringList(SharedPreferencsUtils.KEY_SEARCH_KEY_HISTORY)
        .then((data) {
      setState(() {
        _searchKeyHistory.clear();
        _searchKeyHistory.addAll(data.reversed);
      });
    });
  }

  void _removeSearchHistory(int index) {
    SharedPreferencsUtils.getInstance()
        .removeStringFromList(SharedPreferencsUtils.KEY_SEARCH_KEY_HISTORY,
            _searchKeyHistory[index])
        .then((b) {
      if (b) {
        _getSearchKeyHistory();
      }
    });
  }

  void _clearHistory() {
    DialogUtils.getInstance().showAlertDialog(context, "提示", "你确定要清除所有历史吗",
        positiveStr: "确定", positiveListener: () {
      SharedPreferencsUtils.getInstance()
          .remove(SharedPreferencsUtils.KEY_SEARCH_KEY_HISTORY)
          .then((data) {
        if (data) {
          setState(() {
            _searchKeyHistory.clear();
          });
        }
      });
    }, negativeStr: "取消");
  }

  void _doSearch() {
    if (_controller.text.isEmpty) {
      return;
    }
    setState(() {
      SharedPreferencsUtils.getInstance().saveStringToList(
          SharedPreferencsUtils.KEY_SEARCH_KEY_HISTORY, _controller.text,
          limit: 5);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context){

        return SearchResultPage(_controller.text);}));
//      showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(
//              title: Text("搜索"),
//              content: Text(_controller.text),
//            );
//          });
    });
  }
}
