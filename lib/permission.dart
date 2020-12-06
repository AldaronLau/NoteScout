import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class permission  {
  final PermissionHandler phandler = PermissionHandler();

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Notescout',
      home: Scaffold(
      body: Center( 
        child: MaterialButton(
        color: Colors.blue,
        child: Text('Request Permissione to use the camera'),
        onPressed: (){
    permission().requestCameraPermission(
    onPressedDenied: (){
      print('Permission hs been denied');
    });
    },
    ),
    )
    ));
  }
  
  
Future<bool> requestPermission (PermissionGroup permission) async{

  var result = await phandler.requestPermissions([permission]);
  if (result[permission] == PermissionStatus.granted) {
    return true;
  }
    return false;

}


  Future<bool> requestCameraPermission ({Function onPressedDenied}) async{

    var ward = await requestPermission(PermissionGroup.camera);
    if (!ward) {
      onPressedDenied();
    }
    return ward;

  }

  Future<bool> hasPermission (PermissionGroup permission) async{
    var permissionStatus =
        await phandler.checkPermissionStatus(permission);
        return permissionStatus == PermissionStatus.granted;

  
}

