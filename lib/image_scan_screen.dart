import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
//import 'package:tflite/tflite.dart';
import 'package:csv/csv.dart';

import 'detail_rempah.dart';

class ChooseImagePage extends StatefulWidget {
  ChooseImagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChooseImagePagePage();
  }
}

class _ChooseImagePagePage extends State<ChooseImagePage> {
  var _image = Image(
    image: AssetImage(
      'images/ImagePlaceholder.png',
    ),
    height: 300,
    width: 300,
    fit: BoxFit.cover,
  );
  XFile _imageFile = XFile('images/ImagePlaceholder.png');
  final ImagePicker _picker = ImagePicker();
  List<dynamic> result = [];
  String hasil = "Belum ada";
  double confidence = 0;
  int indeksHasil = 1;
  bool descEnabled = false;
  List<List<dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    //var res = await Tflite.loadModel(
    //    model: "model/model_unquant.tflite", labels: "model/labels.txt");
    //print(res);
  }

  void chooseImage(String mode) async {
    var _checkerImageFile = mode == "camera"
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    if (_checkerImageFile == null) return;
    _imageFile = _checkerImageFile;
    int startTime = DateTime.now().millisecondsSinceEpoch;
    try {
      /*Tflite.runModelOnImage(
        path: _imageFile.path,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 1,
        threshold: 0.4,
      ).then((recognitions) {
        int endTime = DateTime.now().millisecondsSinceEpoch;
        print("Detected in ${endTime - startTime}");
        result = recognitions ?? [];
        if (result.isNotEmpty) indeksHasil = result.first['index'];
        //if (result.isNotEmpty) confidence = double.parse(result.first['confidence']);
        setState(() {
          if (result.isEmpty || result.first['index'] ==0) {
            hasil = "Rempah tidak ditemukan";
            descEnabled = false;
          } else {
            hasil = result.first['label'];
            descEnabled = true;
          }
        });
      });
      */
    } catch (e) {
      print(e);
    }
    setState(() {
      _image = Image.file(
        File(_imageFile.path),
        height: 300,
        width: 300,
        fit: BoxFit.cover,
      );
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri Foto'),
                      onTap: () {
                        chooseImage("gallery");
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      chooseImage("camera");
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<List<List<dynamic>>> loadingCSVData(String path) async {
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

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: loadingCSVData('./database/RempahSIS.csv'),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) data = snapshot.data;
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showPicker(context);
            },
            backgroundColor: Colors.brown,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xffF5F5F5),
          appBar: AppBar(
            backgroundColor: Color(0xFFfdfdfd),
            elevation: 0,
            centerTitle: true,
            title: Text("REMPAHSIS",
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        color: Color(0xffCE8D51), fontWeight: FontWeight.w500),
                    fontSize: 25,
                    letterSpacing: 6)),
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: _image,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                offset: Offset(0, 4),
                                color: Colors.black.withOpacity(0.15))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            hasil,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          descEnabled
                              ? SizedBox(
                                  height: 12,
                                )
                              : SizedBox(),
                          descEnabled ?  MarkdownBody(
                        data: data[indeksHasil][4],
                        styleSheet: MarkdownStyleSheet(
                          textAlign: WrapAlignment.spaceAround,
                            p: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12,)),
                      ): SizedBox(),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  descEnabled
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RempahDetailPage(
                                            id: data[indeksHasil][0].toString())));
                              },
                              child: Text("Informasi Detail")),
                        ],
                      )
                      : SizedBox(),
                  SizedBox(height: 80,)
                ],
              ),
            ),
          ),
        );
      });
}
