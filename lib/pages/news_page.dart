import 'package:flutter/material.dart';

import '../schoolloop/news.dart';
import '../schoolloop/schoolloop.dart';
import '../shared_widgets.dart';
import '../themes.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 25, 5, 5),
      child: RefreshIndicator(
        onRefresh: () async {
          SchoolLoop.sharedInstance.fetchNews();
          setState(() {});
        },
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
              Navigator.pushNamed(context, '/news', arguments: this.news);
            }),
        child: Card(
          color: ThemeColors.backgroundColor,
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
                    Container(
                      width: getTextWidth(context),
                      child: Text(
                        news.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: getTextWidth(context),
                      child: Text(
                        news.authorName,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Icon(
                  Icons.chevron_right,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
