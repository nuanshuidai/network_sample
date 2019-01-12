import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './detail.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
  
  //构造函数
  MovieList({Key key, @required this.mt}):super(key: key);

  //电影类型参数
  final String mt;
  
  @override
  _MovieListState createState() {
    return new  _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build (BuildContext context) {
    return Center(child: _buildSuggestions());
  }

  var gender = '';
  var name = '';
  var location = '';
  var email = '';
  var shuzu;

  int page = 1;
  int pagesize = 20;
  var mlist = [];
  var total = 0;

  static const loadingTag = "##loading##"; //表尾标记
  var items = [];

  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false; //是否正在加载数据

  //下划线widget预定义以供复用。
  Widget divider1 = Divider(color: Colors.grey);
  Widget divider2 = Divider(color: Colors.green);

  @override
  void initState() {
    super.initState();
    getnetwork(page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        print('滑动到了最顶部');
        //_getMore();
      } else if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑到最底部了');
        _getMore();
        //return _getMoreWidget();
        //getnetwork(page);
      }
    });
  }

  

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _buildSuggestions() {
    return new ListView.separated(
        controller: _scrollController,
        itemCount: items.length + 1,
        itemBuilder: _buildRow,
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          //return index%2==0?divider1:divider2;
          return divider1;
        });
  }

  Widget _getMoreWidget() {
    if (mlist.length > 0) {
      return Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: SizedBox(
            width: 18.0,
            height: 18.0,
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ));
    } else if (mlist.length == 0) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Text('已经到底了!', style: TextStyle(fontSize: 12.0)),
      );
    }
  }

  Widget _buildRow(BuildContext context, int i) {
    if (i < items.length) {
      var rmitem = items[i];
      return GestureDetector(
        onTap: (){
          //路由跳转到详情页
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx){
            return MovieDetail(item: rmitem);
          }));
        },
        child: Row(
            children: <Widget>[
              Image.network(rmitem['images']['small'],
                  width: 130, height: 180, fit: BoxFit.cover),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('电影名称：${rmitem['title']}'),
                      Text('上映年份：${rmitem['year']}'),
                      Text('电影类型：${rmitem['genres'].join(',')}'),
                      Text('豆瓣评分：${rmitem['rating']['average']}分'),
                      Text('主要演员：${rmitem['title']}'),
                    ],
                  ))
            ],
        ),
      );
    }
    return _getMoreWidget();
  }

  getnetwork(_page) async {
    //items.insertAll(items.length -1, iterable)
    int offset = (_page - 1) * pagesize;
    // String _url = "https://randomuser.me/api/";
    String _url =
        "http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offset&count=$pagesize";
    var response = await dio.get(_url);
    var results = response.data;
    print('进行第$page' + '页$pagesize' + '条数据查询！');
    print(items.length.toString());
    //print(results);
    //return result;
    setState(() {
      mlist = results['subjects'];
      items.addAll(mlist);
      page++; 
      //print(mlist.length);
    });
  }

  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      getnetwork(page);
      isLoading = false;
    }
  }
}
