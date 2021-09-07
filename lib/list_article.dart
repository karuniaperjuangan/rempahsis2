import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleListPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  ArticleListPage({Key? key, required this.WPList}) : super(key: key);

  List<dynamic> ArticleList = [];
  final List<dynamic> WPList;
  @override
  Widget build(BuildContext buildContext) {
    ArticleList = WPList.length > 0 ? WPList : ArticleList;
    return Scaffold(
        backgroundColor: Color(0xffE0E0E0),
        appBar: AppBar(
            backgroundColor: Color(0xFFfdfdfd),
            elevation: 0,
            centerTitle: true,
            title: Image(
              image: AssetImage('images/LogoPKM.png'),
              height: 60,
            )),
        body: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ArticleList.length > 0
                ? ListView.builder(
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
                                  image: ArticleList[index]['_embedded']
                                                  ['wp:featuredmedia'] !=
                                          null
                                      ? NetworkImage(ArticleList[index]
                                              ['_embedded']['wp:featuredmedia']
                                          [0]['source_url'])
                                      : Image.asset(
                                              'images/ImagePlaceholder.png')
                                          .image,
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
                    })
                : Container()));
  }
}
