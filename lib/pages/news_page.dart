import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../schoolloop/news.dart';
import '../schoolloop/schoolloop.dart';
import '../themes.dart';

News currentNews;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 25, 5, 5),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropMaterialHeader(
          backgroundColor: primaryTheme.primaryColor,
        ),
        controller: _refreshController,
        onLoading: () => setState(() async {
              await SchoolLoop.sharedInstance.fetchNews();
              _refreshController.loadComplete();
            }),
        onRefresh: () => _refreshController.refreshCompleted(),
        child: ListView.builder(
          itemCount: SchoolLoop.sharedInstance.news.length,
          itemBuilder: (_, int index) =>
              NewsWidget(SchoolLoop.sharedInstance.news[index]),
        ),
      ),
    );
  }
}

class NewsWidget extends StatefulWidget {
  final News news;

  NewsWidget(this.news);

  @override
  _NewsWidgetState createState() => _NewsWidgetState(this.news);
}

class _NewsWidgetState extends State<NewsWidget> {
  final News news;

  _NewsWidgetState(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => setState(() {
              currentNews = this.news;
              // TODO Nav push NewsDetails
            }),
        child: Card(
          color: primaryTheme.backgroundColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      //fit: FlexFit.loose,
                      child: Text(
                        news.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryTheme.accentColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      news.authorName,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: primaryTheme.accentColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Icon(
                  Icons.chevron_right,
                  color: primaryTheme.accentColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
