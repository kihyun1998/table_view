import 'package:flutter/material.dart';
import 'package:table_view/example/simple_table/example.dart';
import 'package:table_view/example/simple_table/horizontal.dart';
import 'package:table_view/example/simple_table/vertical.dart';
import 'package:table_view/example/table_view.dart';
import 'package:table_view/talbe/talbe_screen.dart';
import 'package:table_view/test/test1.dart';

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
                    builder: (context) => const Horizontal(),
                  ),
                );
              },
              child: const Text("horizontal"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VerticalScrollbar(),
                  ),
                );
              },
              child: const Text("vertical"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Example(),
                  ),
                );
              },
              child: const Text("example"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Test1(),
                  ),
                );
              },
              child: const Text("test1"),
            ),
          ],
        ),
      ),
    );
  }
}
