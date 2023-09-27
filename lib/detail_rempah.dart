import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rempahsis/model_rempah.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RempahDetailPage extends StatefulWidget {
  final String id;

  RempahDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RempahDetailPage();
  }
}

class _RempahDetailPage extends State<RempahDetailPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: loadingCSVData('./database/RempahSIS.csv'),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
              final _dataRempah = snapshot.data;
                saveLastSeen(_dataRempah);
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('./images/' +
                                  _dataRempah[int.parse(widget.id)][3]),fit: BoxFit.contain, alignment: Alignment.topCenter)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 200),
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 4, spreadRadius: 4)],
                          color: Color(0xffF5F5F5)
                        ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                            SizedBox(height: 20),
                            //Nama Rempah
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(_dataRempah[int.parse(widget.id)][1],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 28)),
                              ],
                            ),
                            //Nama Ilmiah Rempah
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MarkdownBody(
                                  data: _dataRempah[int.parse(widget.id)][2],
                                  styleSheet: MarkdownStyleSheet(
                                      p: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 12)),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //Ikhtisar
                                  Row(
                                    children: [
                                      Flexible(
                                        child: MarkdownBody(
                                          data: _dataRempah[int.parse(widget.id)][4],
                                          styleSheet: MarkdownStyleSheet(
                                              p: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                              textAlign: WrapAlignment.spaceAround),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  expandableInformation(
                                      context: context,
                                      title: "Morfologi",
                                      data: _dataRempah,
                                      infoCol: 5,
                                      refCol: 10),
                                  expandableInformation(
                                      context: context,
                                      title: "Ciri-Ciri",
                                      data: _dataRempah,
                                      infoCol: 6,
                                      refCol: 11),
                                  expandableInformation(
                                      context: context,
                                      title: "Khasiat",
                                      data: _dataRempah,
                                      infoCol: 7,
                                      refCol: 12),
                                  expandableInformation(
                                      context: context,
                                      title: "Kegunaan",
                                      data: _dataRempah,
                                      infoCol: 8,
                                      refCol: 13),
                                  expandableInformation(
                                      context: context,
                                      title: "Potensi",
                                      data: _dataRempah,
                                      infoCol: 9,
                                      refCol: 14),
                                ],
                              ),
                            )
                          ])),
                    ],
                  ),
                );
              } else
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
            }),
      ));

  Future<List<List<dynamic>>> loadingCSVData(String path) async{
    final asset = await rootBundle.load('./database/RempahSIS.csv');
    final csvFile = (await writeToFile(asset)).openRead();
    return await csvFile
    .transform(utf8.decoder)
    .transform(CsvToListConverter())
    .toList();
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  
  void saveLastSeen(dataRempah) async {
    List<ModelRempah> listLastseen = [];
    var lastSeenData = ModelRempah(
      id: dataRempah[int.parse(widget.id)][0],
      namaRempah: dataRempah[int.parse(widget.id)][1],
      namaIlmiah: dataRempah[int.parse(widget.id)][2],
      gambar: dataRempah[int.parse(widget.id)][3],
      ikhtisar: dataRempah[int.parse(widget.id)][4],
      morfologi: dataRempah[int.parse(widget.id)][5],
      ciri: dataRempah[int.parse(widget.id)][6],
      khasiat: dataRempah[int.parse(widget.id)][7],
      kegunaan: dataRempah[int.parse(widget.id)][8],
      potensi: dataRempah[int.parse(widget.id)][9],
      referensiMorfologi: dataRempah[int.parse(widget.id)][10],
      referensiCiri: dataRempah[int.parse(widget.id)][11],
      referensiKhasiat: dataRempah[int.parse(widget.id)][12],
      referensiKegunaan: dataRempah[int.parse(widget.id)][13],
      referensiPotensi: dataRempah[int.parse(widget.id)][14],
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonText = prefs.getString("last_seen");
    if (jsonText != null && jsonText.isNotEmpty) {
      final List lastSeenJosn = jsonDecode(jsonText);
      listLastseen =
          lastSeenJosn.map((val) => ModelRempah.fromJson(val)).toList();
      bool isExisting = false;
      for (int i = 0; i < listLastseen.length; i++) {
        if (listLastseen[i].id == lastSeenData.id) {
          isExisting = true;
          break;
        }
      }
      if (listLastseen.isNotEmpty) {
        if (listLastseen.length == 3) {
          if (!isExisting) {
            List<ModelRempah> newListLastSeen = [];
            newListLastSeen.add(listLastseen[1]);
            newListLastSeen.add(listLastseen[2]);
            newListLastSeen.add(lastSeenData);
            savetoLocal(newListLastSeen, prefs);
          }
        } else {
          if (!isExisting) {
            listLastseen.add(lastSeenData);
            savetoLocal(listLastseen, prefs);
          }
        }
      } else {
        if (!isExisting) {
          listLastseen.add(lastSeenData);
          savetoLocal(listLastseen, prefs);
        }
      }
    } else {
      listLastseen.add(lastSeenData);
      savetoLocal(listLastseen, prefs);
    }
  }

  void savetoLocal(List<ModelRempah> listLastseen, SharedPreferences prefs) {
    String jsonData = jsonEncode(listLastseen);
    prefs.setString("last_seen", jsonData);
  }

  void referensi(context, data, refCol) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.25),
              ),
              child: Container(
                margin: EdgeInsets.all(12),
                child: Wrap(
                  children: <Widget>[
                    MarkdownBody(
                      onTapLink: (text,url,title){if(url != null)launch(url??"");},
                      data: data[int.parse(widget.id)][refCol],
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                        textAlign: WrapAlignment.spaceBetween,
                        listBullet: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                        orderedListAlign: WrapAlignment.spaceBetween,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget expandableInformation(
      {required context,
      required title,
      required data,
      required infoCol,
      required refCol}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.25)),
            borderRadius: BorderRadius.circular(5)
          ),
          child: ExpandablePanel(
              header: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Text(title, ),
                ),
              ),
              collapsed: SizedBox(),
              expanded: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            referensi(context, data, refCol);
                          },
                          child: Text("Referensi")),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  MarkdownBody(
                    data: data[int.parse(widget.id)][infoCol],
                    styleSheet: MarkdownStyleSheet(
                        p: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                        textAlign: WrapAlignment.spaceBetween,
                        unorderedListAlign: WrapAlignment.spaceBetween),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

