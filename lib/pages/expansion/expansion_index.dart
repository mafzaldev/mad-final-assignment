import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';
import 'package:mad_combined_tasks/pages/expansion/expansion_panel_screen.dart';
import 'package:mad_combined_tasks/pages/expansion/expansion_tile_screen.dart';

class ExpansionIndex extends StatefulWidget {
  const ExpansionIndex({super.key});

  @override
  State<ExpansionIndex> createState() => _ExpansionIndexState();
}

class _ExpansionIndexState extends State<ExpansionIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: const CustomAppBar(
            title: "Expansion",
            actions: [],
            height: 150,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.list),
                  text: "Expansion Panel Screen",
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: "Expansion Tile Screen",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [ExpansionPanelScreen(), ExpansionTileScreen()],
          )),
    );
  }
}
