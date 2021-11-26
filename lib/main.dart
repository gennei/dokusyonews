import 'package:flutter/material.dart';
import 'package:dokusyonews/rss_service.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  final RssFeed feed = await RssService().getFeed();
  runApp(MyApp(feed));
}

class MyApp extends StatelessWidget {
  final RssFeed feed;

  MyApp(this.feed);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ブクログ通信',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(feed),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final RssFeed feed;

  HomeScreen(this.feed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ブクログ通信'),
      ),
      body: ListView.builder(
          itemCount: feed.items.length,
          itemBuilder: (BuildContext ctxt, int index) {
            final item = feed.items[index];
            return ListTile(
              title: Text(item.title),
              contentPadding: EdgeInsets.all(16.0),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebView(initialUrl: item.link)));
              },
            );
          }),
    );
  }
}
