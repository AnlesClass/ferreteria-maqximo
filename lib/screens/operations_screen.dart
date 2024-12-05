import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../view_models/view_models.dart';

class OperationsScreen extends StatelessWidget {
  const OperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final operationsViewModel = Provider.of<OperationsViewModel>(context);

    return Scaffold(
      body: Center(
        child: operationsViewModel.widgetsOptions[operationsViewModel.screenIndex]["WIDGET"]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: operationsViewModel.screenIndex,
        items: List.generate(operationsViewModel.widgetsOptions.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(operationsViewModel.widgetsOptions[index]["ICON"]),
            label: operationsViewModel.widgetsOptions[index]["NAME"]
          );
        }),
        onTap: (value) => operationsViewModel.setScreenIndex(value),
      ),
    );
  }
}