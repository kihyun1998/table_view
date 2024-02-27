import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_view/talbe/model.dart';
import 'package:table_view/talbe/provider/selected_provider.dart';

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
