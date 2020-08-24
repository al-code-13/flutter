import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prueba_mobx/src/models/hacker_news.dart';
import 'package:prueba_mobx/src/serializers/news.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _hacker_news = HackerNews();
  final snackBar = SnackBar(
    content: Text('Se actualizaran las noticias'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change!
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    _hacker_news.getNewsList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("NEWS"),
        ),
        body: Observer(
          builder: (context) => RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
              await _hacker_news.increaseNewsLimit();
              Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Container(
              child: Observer(
                builder: (_) => ((_hacker_news.news != null) &&
                        (_hacker_news.news.isNotEmpty))
                    ? ListView.builder(
                        itemCount: _hacker_news.news.length,
                        itemBuilder: (_, index) {
                          final newsArticle = _hacker_news.news[index];
                          return _makeArticleContainer(newsArticle);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
        ),
      );

  Widget _makeArticleContainer(News newsArticle) {
    return Padding(
      //key: Key(newsArticle.title),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
          newsArticle.title,
          style: TextStyle(fontSize: 24.0),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("${newsArticle.by} comments"),
              IconButton(
                onPressed: () async {
                  if (await canLaunch(newsArticle.url)) {
                    launch(newsArticle.url);
                  }
                },
                icon: Icon(Icons.launch),
              )
            ],
          ),
        ],
      ),
    );
  }
}
