import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



void main() => runApp(Perpart());

class Perpart extends StatefulWidget{
  @override
  permission createState() => new permission();
}



class permission extends State<Perpart> {
  final PermissionHandler phandler = PermissionHandler();


  Future<bool> requestPermission(PermissionGroup permission) async {
    var result = await phandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }


  Future<bool> requestCameraPermission({Function onPressedDenied}) async {
    var ward = await requestPermission(PermissionGroup.camera);
    if (!ward) {
      onPressedDenied();
    }
    return ward;
  }


  Future<bool> requestGalleryPermission({Function onPressedDenied}) async {
    var ward = await requestPermission(PermissionGroup.photos);
    if (!ward) {
      onPressedDenied();
    }
    return ward;
  }

  Future<bool> requestMicPermission({Function onPressedDenied}) async {
    var ward = await requestPermission(PermissionGroup.microphone);
    if (!ward) {
      onPressedDenied();
    }
    return ward;
  }

  Future<bool> requestStorePermission({Function onPressedDenied}) async {
    var ward = await requestPermission(PermissionGroup.storage);
    if (!ward) {
      onPressedDenied();
    }
    return ward;
  }


  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
    await phandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }


  @override
  Widget build(BuildContext context) {
        return Scaffold(
            body:  Stack(children: <Widget>[(
            Align(
                alignment: Alignment.centerLeft,
              child: MaterialButton(
                color: Colors.blue,
                child: Text('Camera Permission'),
                onPressed: () {
                  permission().requestCameraPermission(
                      onPressedDenied: () {
                        print('Permission hs been denied');
                      });
                }
              )
            )
        ),

        Align(
        alignment: Alignment.topCenter,
          child: MaterialButton(
            color: Colors.blue,
            child: Text('Gallery Permission'),
            onPressed: () {
              permission().requestGalleryPermission(
                  onPressedDenied: () {
                    print('Permission hs been denied');
                  });
            }
          )
        ),
    Align(
    alignment: Alignment.bottomCenter,
    child: MaterialButton(
    color: Colors.blue,
    child: Text('Microphone Permission'),
    onPressed: () {
    permission().requestMicPermission(
    onPressedDenied: () {
    print('Permission hs been denied');
    });
    }
    )
    ),
    Align(
    alignment: Alignment.centerRight,
    child: MaterialButton(
    color: Colors.blue,
    child: Text('Storage Permission'),
    onPressed: () {
    permission().requestStorePermission(
    onPressedDenied: () {
    print('Permission hs been denied');
    });
    }
    )
    ),
    ]
    )
        );

  }
}