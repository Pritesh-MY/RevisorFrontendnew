import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revisor/res/Screens.dart';
import 'package:revisor/ui/home/provider/BaseProvider.dart';
import 'package:revisor/utils/Utility.dart';
import 'package:revisor/widget/Header.dart';
import 'package:revisor/widget/cards/history_card.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(
              headerText: "History",
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              onBackPressed: () {
                var provider = Provider.of<BaseProvider>(context, listen: false);
                provider.currentScreen = Screens.kHomeScreen;
              },
            ),
            verticalSpace(35.0),
            Expanded(
              child: ListView(
                children: [
                  HistoryCard(),
                  HistoryCard(),
                  HistoryCard(),
                  HistoryCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
