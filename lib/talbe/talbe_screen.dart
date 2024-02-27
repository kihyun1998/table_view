import 'package:flutter/material.dart';
import 'package:table_view/talbe/model.dart';

class TalbeScreen extends StatelessWidget {
  const TalbeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> columns = [
      'ID',
      'Name',
      'Quantity',
      'Price',
    ];

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
      appBar: AppBar(title: const Text("Table")),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                TableHeader(
                  title: "ID",
                ),
                TableHeader(
                  title: "Name",
                  flex: 3,
                ),
                TableHeader(
                  title: "Quantity",
                ),
                TableHeader(
                  title: "Price",
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rows.length,
              itemBuilder: (context, index) {
                final row = rows[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(row.id)),
                      Expanded(flex: 3, child: Text(row.name)),
                      Expanded(flex: 2, child: Text('${row.quantity}')),
                      Expanded(
                          flex: 2,
                          child: Text('\$${row.price.toStringAsFixed(2)}')),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({
    Key? key,
    int? flex,
    required this.title,
  })  : flex = flex ?? 2,
        super(key: key);

  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
