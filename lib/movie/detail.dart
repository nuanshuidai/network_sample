import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {

  MovieDetail({Key key, @required this.item}):super(key:key);

  //final String  id;
  String title;
  var item ;
  
  @override
  _MovieDetailState createState() {
    return _MovieDetailState();
  }
  
}

class _MovieDetailState extends State<MovieDetail> {
  
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text(widget.item['title']),centerTitle: true,),
    body: Container(
      child: Column(
        children: <Widget>[
          Text('电影ID为:'+'${widget.item['id']}'),
          Text('上映时间为:'+'${widget.item['year']}'),
          Text('电影类型:'+'${widget.item['genres'].join(',')}'),
          Text('豆瓣评分:'+'${widget.item['rating']['average']}'),
        ],
      ),
    )
    
    );
  }
}
