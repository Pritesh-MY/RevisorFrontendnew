import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/ui/base/Base.dart';
import 'package:revisor/ui/home/drawer/first_layer.dart';
import 'package:revisor/ui/home/drawer/mid_layer.dart';
import 'package:revisor/ui/home/provider/BaseProvider.dart';

class RevDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseProvider>(
        create: (_) => BaseProvider(),
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                FirstLayer(),
                MidLayer(),
                Base(),
              ],
            ),
          ),
        ));
  }
}
