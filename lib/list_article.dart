import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleListPage extends StatelessWidget {
  ArticleListPage({Key? key, required this.ArticleList}) : super(key: key);

  final List<dynamic> ArticleList;

  @override
  Widget build(BuildContext buildContext) => Scaffold(
      backgroundColor: Color(0xffE0E0E0),
      appBar: AppBar(
          backgroundColor: Color(0xFFfdfdfd),
          elevation: 0,
          centerTitle: true,
          title: Image(image: AssetImage('images/LogoPKM.png'), height: 60,)
          ),
      body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView.builder(
              itemCount: ArticleList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    launch(ArticleList[index]['link']);
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(ArticleList[index]['_embedded']
                                ['wp:featuredmedia'][0]['source_url']),
                            fit: BoxFit.cover)),
                    height: 200,
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      ArticleList[index]['title']['rendered'],
                      style: TextStyle(color: Colors.white, shadows: [
                        Shadow(color: Colors.black, blurRadius: 3)
                      ]),
                    ),
                  ),
                );
              })));
}
