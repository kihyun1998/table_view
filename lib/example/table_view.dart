import 'package:flutter/material.dart';
import 'package:table_view/example/simple_table/simple_table.dart';
import 'package:table_view/talbe/model.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MyDataRow> rows = List.generate(
      5000,
      (index) => MyDataRow(
        id: 'ID$index',
        name: 'Product $index',
        quantity: 100 + index,
        price: 9.99 + index,
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Example of TableView")),
      body: Center(
        child: SimpleTable(
          rows: rows,
          minWidth: 800,
        ),
      ),
    );
  }
}
