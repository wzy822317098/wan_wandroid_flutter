import 'package:flutter/material.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:wan_wandroid/page/WebPage.dart';

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
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[_author(), _info(), _bottom()],
        ),
        onTap: _toWebPage,
      )
    );
  }

  Widget _info() {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          widget.articleEntity.envelopePic != ""
              ? Image.network(
                  widget.articleEntity.envelopePic,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                )
              : Container(),
          Expanded(
            child: Text(
              widget.articleEntity.title,
              textAlign: TextAlign.start,
//              overflow: TextOverflow.visible,
              style: TextStyle(color: Colors.black87, fontSize: 14.0),
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
                ? Text("${widget.articleTag}·",
                    style: TextStyle(color: Colors.red[400], fontSize: 12.0))
                : Text(""),
            Text(
              widget.articleEntity.author,
              style: TextStyle(fontSize: 12.0, color: Colors.black54),
            )
          ])),
          Text(widget.articleEntity.niceDate)
        ]));
  }

  Widget _bottom() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: <Widget>[
          Expanded(
            child: Row(children: [
              new Text("${widget.articleEntity.superChapterName}*",
                  style: new TextStyle(color: Colors.black54, fontSize: 12.0)),
              new Text(
                widget.articleEntity.chapterName,
                style: TextStyle(fontSize: 12.0, color: Colors.black54),
              )
            ]),
          )
        ]));
  }

  void _toWebPage(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return WebPage(widget.articleEntity.title,widget.articleEntity.link);
    }));
  }
}
