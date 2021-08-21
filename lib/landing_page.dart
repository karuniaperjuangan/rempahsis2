import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rempahsis/detail_rempah.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List _items = [];
  String _text = "";
  Random random = new Random();
  final infoController = TextEditingController();

  Future<void> loadJsonData() async {
    final String jsonText = await rootBundle.loadString('assets/info.json');
    final data = await json.decode(jsonText);
    setState(() {
      _items = data;
      _text = _items[random.nextInt(_items.length - 1)]['text'];
    });
  }

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('./images/Background2.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        "Selamat datang",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Ayo mengenal rempah lebih dalam!",
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  fontSize: 26, color: Colors.white))),
                    ],
                  ),
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
                    height: 20,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " Informasi mengenai Rempah",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  " Lihat semua",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffCE8D51)),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text("Bagian ini masih dikembangkan"),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Text(
                              " Rempah terakhir diakses",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Daftar Terakhir
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              dragStartBehavior: DragStartBehavior.down,
                              itemCount: 3,
                              itemBuilder: (context, index) => Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        spreadRadius: -2,
                                      )
                                    ]),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        elevation: 0,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RempahDetailPage(
                                                            id: '5')));
                                          },
                                          child: ListTile(
                                              title: Text(
                                                "Jahe Merah",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Text(
                                                "Zingiber Officinale var Rubrum",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              trailing: Icon(
                                                Icons.navigate_next,
                                                color: Colors.black,
                                              ),
                                              leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image(
                                                  image: AssetImage(
                                                      './images/JaheMerahExample.jpg'),
                                                  height: 45,
                                                  width: 45,
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                        )),
                                  )),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )));
}