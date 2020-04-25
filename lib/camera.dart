import 'dart:async';

import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';


// List<CameraDescription> camera;

Future<void> main() async{
  // camera = await availableCameras();
      runApp(CameraButton());

}

class CameraButton extends StatefulWidget{
  @override
  _cameraState createState() => _cameraState();

}

class _cameraState extends State <CameraButton> {
  // CameraController controller;

  @override
  void initState() {
    super.initState();
    // controller = CameraController(camera[0], ResolutionPreset.medium);
    /* controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }); */
  }

  void dispose (){
    // controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*if (!controller.value.isInitialized) {
      return
        Container();
    }*/
    return Container(); /* AspectRatio(
        aspectRatio:
        // controller.value.aspectRatio,
        child: Container()); // CameraPreview(controller))*/;

  }
}


