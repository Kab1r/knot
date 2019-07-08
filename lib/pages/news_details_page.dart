import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../schoolloop/news.dart';

class NewsDetailsPage extends StatelessWidget {
  final News news;

  NewsDetailsPage(this.news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 5.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    this.news.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Html(
                    onLinkTap: (url) async {
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Invalid URL'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Close'),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ),
                        );
                    },
                    data: this.news.description == 'null'
                        ? 'No Information Provided'
                        : this.news.description.replaceAll('Â', ' '),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
