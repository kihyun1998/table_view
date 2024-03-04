import 'package:flutter/material.dart';

class VerticalScrollbar extends StatefulWidget {
  const VerticalScrollbar({super.key});

  @override
  _VerticalScrollbarState createState() => _VerticalScrollbarState();
}

class _VerticalScrollbarState extends State<VerticalScrollbar> {
  final ScrollController _verticalScrollController = ScrollController();
  bool _isHoveringVertical = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical Dynamic Scrollbars with Rows'),
      ),
      body: MouseRegion(
        onEnter: (_) => setState(() => _isHoveringVertical = true),
        onExit: (_) => setState(() => _isHoveringVertical = false),
        child: Scrollbar(
          controller: _verticalScrollController,
          thumbVisibility: _isHoveringVertical,
          child: ListView.builder(
            controller: _verticalScrollController,
            itemCount: 20, // Number of items in the list
            itemBuilder: (context, index) => SizedBox(
              height: 100, // Height of each row
              child: Row(
                children: [
                  // Example of multiple containers within a row for each list item
                  for (int i = 0;
                      i < 3;
                      i++) // Creates 3 containers in each row
                    Expanded(
                      child: Container(
                        color: Colors.green[(index % 9 + 1) * 100],
                        child: Center(
                          child: Text(
                              'Item ${index}_$i'), // Unique text for each container
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
