import 'package:flutter/material.dart';

class ExpansionPanelScreen extends StatefulWidget {
  @override
  _ExpansionPanelScreenState createState() => _ExpansionPanelScreenState();
}

class _Data {
  String header;
  String body;
  bool isExpanded;

  _Data({
    // ignore: unused_element
    this.isExpanded = false,
    required this.header,
    required this.body,
  });
}

class _ExpansionPanelScreenState extends State<ExpansionPanelScreen> {
  final List<_Data> _dataList = [
    _Data(header: 'Step 1', body: 'Open the app and click on login button.'),
    _Data(header: 'Step 2', body: 'Open the drawer.'),
    _Data(header: 'Step 3', body: 'Click on any of the drawer item.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _dataList[index].isExpanded = !isExpanded;
              });
            },
            children: _dataList.map<ExpansionPanel>((item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.header),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(item.body),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
