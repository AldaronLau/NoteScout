import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class permission extends StatefulWidget {
  @override
  _permissionstate createState() => _permissionstate();
}

class _permissionstate extends State<permission> {
  Map<PermissionGroup, PermissionStatus> permissions;
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  // Groups together what should be acessed
  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.photos,
      PermissionGroup.camera,
      PermissionGroup.phone,
    ]);
  }

  ///Builds a widget
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
      )),
    );
  }
}

/*// Pops up an access button. Supposedly it should bring a popup asking for permission
class RequestAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permission needed',
      theme: new ThemeData(primaryColor: Colors.blueAccent),
      home: new permission(),
    );
  }
}*/
