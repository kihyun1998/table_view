import 'package:flutter/material.dart';
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
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TalbeScreen(),
            ));
          },
          child: const Text("Column"),
        ),
      ),
    );
  }
}
