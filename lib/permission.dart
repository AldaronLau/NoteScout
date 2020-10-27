import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class permission extends StatefulWidget {
  @override
  _permissionstate createState() => _permissionstate();
}

class _permissionstate extends State<permission> {
  Map<PermissionGroup, PermissionStatus> permissions;
  @override
  void initState(){
    super.initState();
    getPermission();
  }

  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.photos,
      PermissionGroup.camera,
      PermissionGroup.phone,
    ]);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask for permisions please'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text("All Permission Granted"),
            ],
          )
      ),

    );
  }
}