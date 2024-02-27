import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_view/talbe/model.dart';
import 'package:table_view/talbe/provider/selected_provider.dart';

// final selectedRowsProvider = StateProvider<Set<String>>((ref) => {});

class TalbeScreen extends ConsumerWidget {
  const TalbeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final List<String> columns = [
    //   'ID',
    //   'Name',
    //   'Quantity',
    //   'Price',
    // ];

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
          /// TableHeaders
          const TableColumn(),

          /// TableRows
          TableRow(rows: rows),
        ],
      ),
    );
  }
}

/// Table Columns Field
class TableColumn extends ConsumerWidget {
  const TableColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRows = ref.watch(selectedRowProvider);
    final bool isAllSelected = selectedRows.length == 5000;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: isAllSelected,
            onChanged: (bool? value) {
              ref.read(selectedRowProvider.notifier).selectAll(value);
            },
          ),
          const TableHeader(
            title: "ID",
          ),
          const TableHeader(
            title: "Name",
            flex: 3,
          ),
          const TableHeader(
            title: "Quantity",
          ),
          const TableHeader(
            title: "Price",
          ),
        ],
      ),
    );
  }
}

/// Table Rows Field
class TableRow extends ConsumerWidget {
  const TableRow({
    super.key,
    required this.rows,
  });

  final List<MyDataRow> rows;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRows = ref.watch(selectedRowProvider);
    return Expanded(
      child: ListView.separated(
        /// row's length
        itemCount: rows.length,

        /// item builder
        /// Area to make rows
        itemBuilder: (context, index) {
          final row = rows[index];
          final isSelected = selectedRows.contains(row.id);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (bool? value) {
                    ref
                        .read(selectedRowProvider.notifier)
                        .update(value, row.id);
                  },
                ),
                TableData(title: row.id),
                TableData(title: row.name, flex: 3),
                TableData(title: '${row.quantity}'),
                TableData(title: '\$${row.price.toStringAsFixed(2)}'),
              ],
            ),
          );
        },

        /// Area for divider
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}

/// Table Data Tile
class TableData extends StatelessWidget {
  const TableData({
    Key? key,
    this.flex = 2,
    required this.title,
  }) : super(key: key);

  final int flex;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(title),
      ),
    );
  }
}

/// Talbe Header Tile
class TableHeader extends StatelessWidget {
  const TableHeader({
    Key? key,
    this.flex = 2,
    required this.title,
  }) : super(key: key);

  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8), // 패딩 추가
        decoration: BoxDecoration(
          color: Colors.blueGrey[100], // 배경색 추가
          border: const Border(
            right: BorderSide(color: Colors.grey, width: 0.5), // 우측 경계선 추가
            bottom: BorderSide(color: Colors.grey, width: 0.5), // 하단 경계선 추가
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87, // 텍스트 색상 변경
          ),
          textAlign: TextAlign.center, // 텍스트 중앙 정렬
        ),
      ),
    );
  }
}
