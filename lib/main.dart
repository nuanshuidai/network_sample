import 'package:flutter/material.dart';
import './movie/list.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: '电影列表'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  

  
  @override
  Widget build(BuildContext context) {
   //var title_text = "电影列表";

    return DefaultTabController(length: 3,child: Scaffold(
      appBar: AppBar(
        title: Text("电影列表"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('暖水袋'),
              accountEmail: Text("nuanshuidai@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://qlogo1.store.qq.com/qzone/43566660/43566660/100?1527139903'),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://n4-q.mafengwo.net/s12/M00/DA/01/wKgED1wm4MmAFvUFAALaLOsRaGg84.jpeg?imageMogr2%2Finterlace%2F1'))),
            ),
            ListTile(
              title: Text('用户反馈'),
              trailing: Icon(Icons.feedback),
            ),
            ListTile(
              title: Text('系统设置'),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('我要发布'),
              trailing: Icon(Icons.send),
            ),
            Divider(),
            ListTile(
              title: Text('注销用户'),
              trailing: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.black),
        height: 50,
        child: TabBar(
          labelStyle: TextStyle(height: 0,fontSize: 10),
          tabs: <Widget>[
        Tab(icon: Icon(Icons.movie_filter),text:'正在热映',),
        Tab(icon: Icon(Icons.movie_creation),text:'院线大片',),
        Tab(icon: Icon(Icons.local_movies),text:'排行榜',),        
      ],)),
      body: TabBarView(children: <Widget>[
        MovieList(mt: 'in_theaters',),
        MovieList(mt: 'coming_soon'),
        MovieList(mt: 'top250'),
        //Center(child: _buildSuggestions()),
      ],)
      //
    ),);
  }
}
