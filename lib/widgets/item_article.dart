import 'package:flutter/material.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:wan_wandroid/page/web_page.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

///@description 文章item组件
///
///@created by wangzhouyao on 2019-07-10
class ItemArticle extends StatefulWidget {
  final ArticleEntity articleEntity;
  final String articleTag;

  const ItemArticle({Key key, this.articleEntity, this.articleTag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemArticleState();
}

class ItemArticleState extends State<ItemArticle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 4,right: 4),
          color: ColorsUtils.color_bg,
          child: Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[_author(), _info(), _bottom()],
            ),
          )),
      onTap: _toWebPage,
    );
  }

  Widget _info() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.articleEntity.envelopePic != ""
              ? Container(
            margin: EdgeInsets.only(right: 10),
            child: Image.network(

              widget.articleEntity.envelopePic,
              width: 80,
              height: 60,
              fit: BoxFit.cover,
            ),
          )
              : Container(),
          Expanded(
            child: Text(
              widget.articleEntity.title,
              textAlign: TextAlign.left,
              style: TextStyle(color: ColorsUtils.color_title, fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _author() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: <Widget>[
          Expanded(
              child: Row(children: <Widget>[
            widget.articleTag != null
                ? Text("${widget.articleTag} · ",
                    style: TextStyle(color: Colors.red[400], fontSize: 12.0))
                : Text(""),
            Text(
              widget.articleEntity.author,
              style:
                  TextStyle(fontSize: 12.0, color: ColorsUtils.color_content),
            )
          ])),
          Text(widget.articleEntity.niceDate)
        ]));
  }

  Widget _bottom() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(children: <Widget>[
          Expanded(
            child: Row(children: [
              new Text("${widget.articleEntity.superChapterName} · ",
                  style: new TextStyle(
                      color: ColorsUtils.color_content, fontSize: 12.0)),
              new Text(
                widget.articleEntity.chapterName,
                style:
                    TextStyle(fontSize: 12.0, color: ColorsUtils.color_content),
              )
            ]),
          )
        ]));
  }

  void _toWebPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WebPage(
          title: widget.articleEntity.title, url: widget.articleEntity.link);
    }));
  }
}
