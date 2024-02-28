import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_view/talbe/model.dart';
import 'package:table_view/talbe/provider/selected_provider.dart';

class SimpleTable extends ConsumerWidget {
  const SimpleTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MyDataRow> rows = List.generate(
      5000,
      (index) => MyDataRow(
        id: 'ID$index',
        name: 'Product $index',
        quantity: 100 + index,
        price: 9.99 + index,
      ),
    );

    final ScrollController scrollController = ScrollController();
    const double minWidth = 800;

    return Scaffold(
      appBar: AppBar(title: const Text("Table")),
      body: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double tableWidth = constraints.maxWidth > minWidth
                ? constraints.maxWidth
                : minWidth;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: SizedBox(
                width: tableWidth,
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: _StickyHeaderDelegate(
                        height: 56,
                        child: const TableColumn(),
                      ),
                      pinned: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final row = rows[index];
                          return TableRowWidget(row: row);
                        },
                        childCount: rows.length,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StickyHeaderDelegate({
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      color: Colors.white,
      child: child,
    );
  }

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
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

/// Table Row widget
class TableRowWidget extends ConsumerWidget {
  const TableRowWidget({Key? key, required this.row}) : super(key: key);

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
              TableData(title: row.id),
              TableData(title: row.name, flex: 3),
              TableData(title: '${row.quantity}'),
              TableData(title: '\$${row.price.toStringAsFixed(2)}'),
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
