import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rempahsis/detail_rempah.dart';
import 'package:rempahsis/list_article.dart';
import 'package:rempahsis/model_rempah.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

List<dynamic> _ArticleList = [];

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List _items = [];

  List<ModelRempah> lastSeenList = [];
  String _text = "";
  Random random = new Random();
  final infoController = TextEditingController();

  Future<void> loadWordpressArticle() async {
    if(_ArticleList.length>0) return;
    final response =
        await Dio().get('https://rempahsis.id/wp-json/wp/v2/posts?_embed');
    _ArticleList = response.data;
  }

  Future<void> loadJsonData() async {
    final String jsonText = await rootBundle.loadString('assets/info.json');
    final data = await json.decode(jsonText);
    setState(() {
      _items = data;
      _text = _items[random.nextInt(_items.length - 1)]['text'];
    });
  }

  Future<String?> loadLastSeenData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var jsonText = pref.getString("last_seen");
    return jsonText;
  }

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          //margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
          child: Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  color: Colors.amber,
                  child: Image.asset(
                    './images/background_main.png',
                    fit: BoxFit.fill,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3 -
                          MediaQuery.of(context).size.height / 4 -
                          20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Selamat datang",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                    Text("Ayo mengenal rempah lebih dalam!",
                        style: GoogleFonts.oswald(
                            textStyle:
                                TextStyle(fontSize: 26, color: Colors.white))),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ListTile(
                        minVerticalPadding: 20,
                        title: Text(
                          "Tahukah kamu?",
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          _text,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " Artikel seputar Rempah",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ArticleListPage(
                                                      WPList:
                                                          _ArticleList)));
                                    },
                                    child: Text(
                                      "Lihat semua",
                                      style: GoogleFonts.oswald(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffCE8D51)),
                                      ),
                                    ))
                              ],
                            ),
                            FutureBuilder(
                                future: loadWordpressArticle(),
                                builder: (context, snapshot) {
                                  return snapshot.connectionState ==
                                          ConnectionState.done
                                      ? Container(
                                          height: 250,
                                          child: ListView.builder(
                                            itemCount: 3,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                RempahArticleCard(
                                                    index: random.nextInt(
                                                        _ArticleList.length)),
                                          ),
                                        )
                                      : CircularProgressIndicator();
                                }),
                            Row(
                              children: [
                                Text(
                                  " Rempah terakhir diakses",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            //Daftar Terakhir
                            FutureBuilder(
                              future: loadLastSeenData(),
                              builder: (context, AsyncSnapshot snapshot) {
                                final jsonData = snapshot.data;
                                if (snapshot.hasData) {
                                  List<ModelRempah> lastSeenDataList = [];
                                  final List lastSeenDataJson =
                                      jsonDecode(jsonData);
                                  lastSeenDataList = lastSeenDataJson
                                      .map((val) => ModelRempah.fromJson(val))
                                      .toList();
                                  return Container(
                                      child: lastSeenDataList.length > 0
                                          ? ListView.builder(
                                              itemCount:
                                                  lastSeenDataList.length,
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (context, index) => Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.05),
                                                                blurRadius: 4,
                                                                spreadRadius:
                                                                    -2,
                                                              )
                                                            ]),
                                                        child: Card(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            elevation: 0,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RempahDetailPage(id: lastSeenDataList[index].id.toString())));
                                                              },
                                                              child: ListTile(
                                                                  title: Text(
                                                                    lastSeenDataList[
                                                                            index]
                                                                        .namaRempah!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  //Nama Ilmiah
                                                                  subtitle:
                                                                      MarkdownBody(
                                                                    data: lastSeenDataList[
                                                                            index]
                                                                        .namaIlmiah!,
                                                                    styleSheet: MarkdownStyleSheet(
                                                                        p: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w300)),
                                                                  ),
                                                                  trailing:
                                                                      Icon(
                                                                    Icons
                                                                        .navigate_next,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  leading:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child:
                                                                        Image(
                                                                      image: AssetImage(
                                                                          './images/' +
                                                                              lastSeenDataList[index].gambar!),
                                                                      height:
                                                                          45,
                                                                      width: 45,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  )),
                                                            )),
                                                      ))
                                          : Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Tidak ada data",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ));
                                } else
                                  return Center();
                              },
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
//Container(
//decoration: BoxDecoration(
//image: DecorationImage(
//  image: AssetImage('./images/Background2.png'), fit: BoxFit.fill),
//),
//child: );
}

class RempahArticleCard extends StatelessWidget {
  const RempahArticleCard({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launch(_ArticleList[index]['link']);
      },
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                                  image: _ArticleList[index]['_embedded']
                                                  ['wp:featuredmedia'] !=
                                          null
                                      ? NetworkImage(_ArticleList[index]
                                              ['_embedded']['wp:featuredmedia']
                                          [0]['source_url'])
                                      : Image.asset(
                                              'images/ImagePlaceholder.png')
                                          .image,
                                  fit: BoxFit.cover)),
        height: 200,
        width: 200,
        alignment: Alignment.bottomLeft,
        child: Text(
          _ArticleList[index]['title']['rendered'],
          style: TextStyle(
              color: Colors.white,
              shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
        ),
      ),
    );
  }
}
