

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'main.dart';

class RempahScannerScreen extends StatefulWidget{
  



  @override
  RempahScannerState createState() => RempahScannerState();
}

class RempahScannerState extends State<RempahScannerScreen>{
  

  bool isDetecting = false;
  List<dynamic> result = [];
  String hasil = "";

  @override
  void initState(){
    super.initState();
    loadModel();
  }


  @override
  Widget build(BuildContext context){
    return Camera();
  }
  

  loadModel() async {
        var res = await Tflite.loadModel(
            model: "model/mobilenet_v2_1.0_224.tflite",
            labels: "model/labels.txt");
    print(res);
  }

}

class Camera extends StatefulWidget{

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;

  late Future<void> _initializeControllerFuture;

  bool isDetecting = false;

  List<dynamic> result = [];

  String hasil = "";

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  initState(){
    super.initState();
    _controller = CameraController(
      camera, 
      ResolutionPreset.max);
    _initializeControllerFuture = _controller.initialize().then(
      (value) {if(!mounted) return;
      setState(() {});
      _controller.startImageStream((image) async{
        await Future.delayed(Duration(seconds: 1));
        if(!isDetecting){
          isDetecting = true;
          int startTime = DateTime.now().millisecondsSinceEpoch;
          try{
          Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) => plane.bytes).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            imageMean: 127.5,
            imageStd: 127.5,
            numResults: 1,
            threshold: 0.4,
            )
            .then((recognitions){
              int endTime = DateTime.now().millisecondsSinceEpoch;
              print("Detected in ${endTime - startTime}");
              result = recognitions??[];
              setState(() {
                hasil= result.toString();
              });
            });}
            catch(e){print(e);}
            isDetecting = false;
        }

      });
      
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future:  Future.wait([_initializeControllerFuture]),
        builder: (context,snapshot){
          if(_controller.value.isInitialized){
            return Stack(
              children: [
                CameraPreview(_controller),
                Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(hasil, style: TextStyle(color: Colors.black),),
                  SizedBox(height: 48,),
                ],)
              ],
            );
          }
          else return const Center(child: CircularProgressIndicator(),);
        },
        ),
    );
  }
}