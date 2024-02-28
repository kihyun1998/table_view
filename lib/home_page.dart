import 'package:flutter/material.dart';
import 'package:table_view/example/simple_table/spage.dart';
import 'package:table_view/example/table_view.dart';
import 'package:table_view/talbe/talbe_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TableScreen(),
                  ),
                );
              },
              child: const Text("Column"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TablePage(),
                  ),
                );
              },
              child: const Text("Table page"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScrollableTableExample(),
                  ),
                );
              },
              child: const Text("scroll page"),
            ),
          ],
        ),
      ),
    );
  }
}
