import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_view/talbe/model.dart';
import 'package:table_view/talbe/provider/selected_provider.dart';

class SimpleTable extends ConsumerStatefulWidget {
  const SimpleTable({
    super.key,
    required this.rows,
    this.padding,
    double? minWidth,
  }) : minWidth = minWidth ?? 0.0;

  final List<dynamic> rows;
  final double minWidth;
  final EdgeInsetsGeometry? padding;

  @override
  ConsumerState<SimpleTable> createState() => _SimpleTableState();
}

class _SimpleTableState extends ConsumerState<SimpleTable> {
  bool _isHover = false;
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: Scrollbar(
        controller: _horizontalScrollController,
        thumbVisibility: _isHover,
        child: Scrollbar(
          controller: _verticalScrollController,
          thumbVisibility: _isHover,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double tableWidth = constraints.maxWidth > widget.minWidth
                  ? constraints.maxWidth
                  : widget.minWidth;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _horizontalScrollController,
                child: Container(
                  padding: widget.padding,
                  width: tableWidth,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        child: const TableHeader(),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _verticalScrollController,
                          itemCount: widget.rows.length,
                          itemBuilder: (context, index) {
                            return TableDataField(row: widget.rows[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Table Columns Field
class TableHeader extends ConsumerWidget {
  const TableHeader({
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
          const TableHeaderTile(
            title: "ID",
          ),
          const TableHeaderTile(
            title: "Name",
          ),
          const TableHeaderTile(
            title: "Quantity",
          ),
          const TableHeaderTile(
            title: "Price",
          ),
        ],
      ),
    );
  }
}

/// Talbe Header Tile
class TableHeaderTile extends StatelessWidget {
  const TableHeaderTile({
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
        decoration: const BoxDecoration(
            // color: Colors.blueGrey[100], // 배경색 추가
            // border: const Border(
            //   right: BorderSide(color: Colors.grey, width: 0.5),
            //   bottom: BorderSide(color: Colors.grey, width: 0.5),
            // ),
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

/// Table Row widget
class TableDataField extends ConsumerWidget {
  const TableDataField({Key? key, required this.row}) : super(key: key);

  final MyDataRow row;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRows = ref.watch(selectedRowProvider);
    final isSelected = selectedRows.contains(row.id);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  ref.read(selectedRowProvider.notifier).update(value, row.id);
                },
              ),
              TableDataTile(title: row.id),
              TableDataTile(title: row.name),
              TableDataTile(title: '${row.quantity}'),
              TableDataTile(title: '\$${row.price.toStringAsFixed(2)}'),
            ],
          ),
        ),

        /// 구분자
        const Divider(height: 1)
      ],
    );
  }
}

/// Table Data Tile
class TableDataTile extends StatelessWidget {
  const TableDataTile({
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
