import 'package:flutter/material.dart';
import 'package:wan_wandroid/network/NetworkUtil.dart';
import 'package:wan_wandroid/model/hot_key_model.dart';
import 'package:wan_wandroid/widgets/hot_key_flow_delegate.dart';
import 'package:wan_wandroid/utils/shared_preferences_utils.dart';

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
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            hintText: '用空格隔开多个关键字',
            filled: true,
//              border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(10.0),
//                  borderSide: BorderSide(color: Colors.blueGrey[300]))
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
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
                        child: Text(
                          '清除所有',
                          style: TextStyle(color: Colors.red[300]),
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
                        contentPadding: EdgeInsets.only(left: 0,right: 0),
                        title: Text(
                          _searchKeyHistory[index],
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.delete), onPressed: (){_removeSearchHistory(index);}),
                        onTap: (){
                          _controller.text =_searchKeyHistory[index];
                          _doSearch();
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
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

  void _removeSearchHistory(int index){
    SharedPreferencsUtils.getInstance().removeStringFromList(SharedPreferencsUtils.KEY_SEARCH_KEY_HISTORY, _searchKeyHistory[index])
        .then((b){
       if(b){
         _getSearchKeyHistory();
       }
    });
  }

  void _clearHistory() {
    SharedPreferencsUtils.getInstance()
        .remove(SharedPreferencsUtils.KEY_SEARCH_KEY_HISTORY)
        .then((data) {
      if (data) {
        setState(() {
          _searchKeyHistory.clear();
        });
      }
    });
  }

  void _doSearch() {
    if(_controller.text.isEmpty){
      return;
    }
    setState(() {
      SharedPreferencsUtils.getInstance().saveStringToList(
          SharedPreferencsUtils.KEY_SEARCH_KEY_HISTORY, _controller.text,
          limit: 5);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("搜索"),
              content: Text(_controller.text),
            );
          });
    });
  }
}
