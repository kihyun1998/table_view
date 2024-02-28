import 'package:flutter/material.dart';

class ScrollableTableExample extends StatelessWidget {
  const ScrollableTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scrollable Table Example'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: List<DataColumn>.generate(
                10,
                (index) => DataColumn(label: Text('Column $index')),
              ),
              rows: List<DataRow>.generate(
                20,
                (index) => DataRow(
                  cells: List<DataCell>.generate(
                    10,
                    (cellIndex) => DataCell(Text('Item $index, $cellIndex')),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
