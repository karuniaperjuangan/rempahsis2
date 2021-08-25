import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rempahsis/detail_rempah.dart';


class RempahListPage extends StatefulWidget{
  RempahListPage({Key? key}) : super(key: key);

  @override
  _RempahListPageState createState() => _RempahListPageState();
}



class _RempahListPageState extends State<RempahListPage>{

  late Future _future;

  bool isInitialized = false;

  List<List<dynamic>> _dataRempah = [];

  List<List<dynamic>> _dataFilter = [];
  @override
  void initState() {
    _future = loadingCSVData('./database/RempahSIS.csv');
    super.initState();
    isInitialized = false;
  }
  List<List<dynamic>> hasil = [];

  void _filter(String kata) {
    if(kata.isEmpty){
      hasil =_dataRempah;
    }
    else{
      hasil = _dataRempah.where((x) => x[1].toLowerCase().contains(kata)).toList();
    }
    setState( (){
      _dataFilter = hasil;
    });
  }



  @override
  Widget build(BuildContext buildContext) => Scaffold(
      backgroundColor: Color(0xffE0E0E0),
      appBar:  AppBar(
          backgroundColor: Color(0xFFfdfdfd),
          elevation: 0,
          title: Container(
            height: 40,
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffeaeaea),
            ),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  prefixIcon: Icon(Icons.search, size: 18,),
                  hintText: "Search...",
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              style: TextStyle(color: Colors.grey[800],),
              onChanged: (value) => _filter(value),
              textAlignVertical: TextAlignVertical.center,
            ),
          )


      ),
      body: Padding(padding: EdgeInsets.only(left: 15, right: 15),
        child: FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                _dataRempah = (snapshot.data);
                _dataRempah = _dataRempah.sublist(1);
                if(!isInitialized){
                  _dataFilter = _dataRempah;
                  isInitialized = true;
                }

                return Column(children: [
                  //SizedBox(height: 20,),
                  Expanded(child: _dataFilter.length>0
                      ?ListView.builder(
                      itemCount: _dataFilter.length,
                      itemBuilder: (context,index)
                      => Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: -2,
                          )
                        ]),
                        child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            margin: EdgeInsets.only(top: index == 0? 10: 0, bottom:10),
                            child: MaterialButton(
                              onPressed:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => RempahDetailPage(id: _dataFilter[index][0].toString())));
                              },
                              child: ListTile(
                                  title: Text(_dataFilter[index][1],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                  //Nama Ilmiah
                                  subtitle: MarkdownBody(data: _dataFilter[index][2],
                                    styleSheet: MarkdownStyleSheet(p: TextStyle(fontSize: 12,fontWeight: FontWeight.w300)),),

                                  trailing: Icon(Icons.navigate_next, color: Colors.black,),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(image: AssetImage('./images/'+_dataFilter[index][3]), height: 45, width: 45, fit: BoxFit.fill,),
                                  )
                              ),
                            )
                        ),
                      )
                  )
                      :Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rempah tidak ditemukan",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                            Text("☹",style: TextStyle(fontSize: 64),)]
                      )
                  )

                  )
                ],
                );}
              else return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              );
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

