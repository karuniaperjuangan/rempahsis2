import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class RempahDetailPage extends StatefulWidget{
  final String id;
  RempahDetailPage({Key? key,required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState(){
    return _RempahDetailPage();  
}
}
class _RempahDetailPage extends State<RempahDetailPage>{
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xffF5F5F5),
    appBar: AppBar(
      backgroundColor: Color(0xFFfdfdfd),
      elevation: 0,
      centerTitle: true,
      title: Text("REMPAHSIS",
      style: GoogleFonts.oswald(
        textStyle: TextStyle(
          color: Color(0xffCE8D51),
          fontWeight: FontWeight.w500),
          fontSize: 25,
          letterSpacing: 6
          )),
      ),
    body: SingleChildScrollView(child:
    FutureBuilder(
      future: loadingCSVData('./database/RempahSIS.csv') ,
      builder: (context, AsyncSnapshot snapshot) {
        final _dataRempah = snapshot.data;
        return snapshot.hasData?
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            //Nama Rempah
            Text(_dataRempah[int.parse(widget.id)][1], 
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28)
            ),
            //Nama Ilmiah Rempah
            MarkdownBody(data: _dataRempah[int.parse(widget.id)][2], styleSheet: MarkdownStyleSheet(p: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),),
            SizedBox(height: 15),
            //Gambar Rempah
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(image: AssetImage('./images/'+_dataRempah[int.parse(widget.id)][3]), width: 300,
            )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Ikhtisar
                  Row(children: [Flexible(child: MarkdownBody(data: 
                  _dataRempah[int.parse(widget.id)][4], 
                  styleSheet: MarkdownStyleSheet(p: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),textAlign: WrapAlignment.spaceAround),),
                  ),
                  ],
                  ),
                  SizedBox(height: 10,),
                  //Morfologi
                  ExpandablePanel(
                    header: Text("Morfologi"),
                    collapsed: Text(""),
                    expanded: MarkdownBody(data: 
                  _dataRempah[int.parse(widget.id)][5], 
                  styleSheet: MarkdownStyleSheet(p: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),textAlign: WrapAlignment.spaceBetween),)
                  ),
                  SizedBox(height: 10,),
                  //Ciri-ciri
                  ExpandablePanel(
                    header: Text("Ciri-ciri"),
                    collapsed: Text(""),
                    expanded: MarkdownBody(data: 
                  _dataRempah[int.parse(widget.id)][6], 
                  styleSheet: MarkdownStyleSheet(p: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),textAlign: WrapAlignment.spaceBetween),)),
                  SizedBox(height: 10,),
                  //Khasiat
                  ExpandablePanel(
                    header: Text("Khasiat"),
                    collapsed: Text(""),
                    expanded: MarkdownBody(data: 
                  _dataRempah[int.parse(widget.id)][7], 
                  styleSheet: MarkdownStyleSheet(p: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),textAlign: WrapAlignment.spaceBetween),)), 
                  SizedBox(height: 10,),
                  //Kegunaan
                  ExpandablePanel(
                    header: Text("Kegunaan"),
                    collapsed: Text(""),
                    expanded: MarkdownBody(data: 
                  _dataRempah[int.parse(widget.id)][8], 
                  styleSheet: MarkdownStyleSheet(p: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),textAlign: WrapAlignment.spaceBetween),)),
                  SizedBox(height: 10,),
                  //Potensi
                  ExpandablePanel(
                    header: Text("Potensi"),
                    collapsed: Text(""),
                    expanded: MarkdownBody(data: 
                  _dataRempah[int.parse(widget.id)][9], 
                  styleSheet: MarkdownStyleSheet(p: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),textAlign: WrapAlignment.spaceBetween),)),
                ],
              ),
            )
          ]
          )
        )
        :CircularProgressIndicator();
      }
    ),
    )
  );

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
    var filePath = tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
}