import 'package:client/pages/dashboard.dart';
import 'package:client/pages/notimplemented.dart';
import 'package:client/pages/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoHome extends StatefulWidget {
  const NoHome({Key? key}) : super(key: key);

  @override
  State<NoHome> createState() => _NoHomeState();
}

class _NoHomeState extends State<NoHome> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(width: 300, child: Sidebar()),
          Expanded(child: NotImplemented())
        ],
      ),
    );
  }
}
