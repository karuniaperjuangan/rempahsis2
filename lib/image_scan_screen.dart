import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rempahsis/main.dart';
import 'package:tflite/tflite.dart';

class ChooseImagePage extends StatefulWidget {
  

  ChooseImagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChooseImagePagePage();
  }
}

class _ChooseImagePagePage extends State<ChooseImagePage> {
  
  var _image = Image(image: AssetImage('images/ImagePlaceholder.png',),height: 400,fit: BoxFit.contain,);
  XFile _imageFile = XFile('images/ImagePlaceholder.png');
  final ImagePicker _picker = ImagePicker();
  List<dynamic> result = [];
  String hasil = "Belum ada";
  double confidence = 0;

  @override
  void initState() {
    super.initState();
    loadModel();
  }


  loadModel() async {
    var res = await Tflite.loadModel(
        model: "model/model_unquant.tflite", labels: "model/labels.txt");
    print(res);
  }

  void chooseImage(String mode) async {
    var _checkerImageFile = mode == "camera"? await _picker.pickImage(source: ImageSource.camera): await _picker.pickImage(source: ImageSource.gallery);
    if(_checkerImageFile == null) return;
    _imageFile = _checkerImageFile;
    int startTime = DateTime.now().millisecondsSinceEpoch;
    try {
      Tflite.runModelOnImage(
        path: _imageFile.path,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 1,
        threshold: 0.4,
      ).then((recognitions) {
        int endTime = DateTime.now().millisecondsSinceEpoch;
        print("Detected in ${endTime - startTime}");
        result = recognitions ?? [];
        //if (result.isNotEmpty) confidence = double.parse(result.first['confidence']);
        setState(() {
          if(result.isEmpty) hasil = "Rempah tidak ditemukan";
          else hasil = "Rempah ini teridentifikasi sebagai " + result.first['label'].toString();
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      _image = Image.file(
        File(_imageFile.path),
        height: 400,
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
      }
    );
}

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
              SizedBox(height: 20,),
              Text("Tekan gambar untuk mulai mengidentifikasi rempah", textAlign: TextAlign.center,),
              SizedBox(height:40),
              InkWell(
                onTap: (){_showPicker(context);},
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: _image,
                ),
              ),
              SizedBox(height:40),
              Text(hasil,softWrap: true,textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
      );
}