import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Page Selector',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 74),
      ),
      home: const MyHomePage(),
    );
  }
}

List<Widget> pages = const [
  Icon(Icons.home),
  Icon(Icons.settings),
  Icon(Icons.person),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: pages.length,
      vsync: this,
      initialIndex: _index,
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab Page Selector'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            TabBarView(
              controller: _tabController,
              children: pages,
            ),
            Positioned(
              bottom: 40,
              child: TabPageSelector(
                controller: _tabController,
                color: Colors.black,
                selectedColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton.small(
            backgroundColor: Colors.orange,
            hoverElevation: 0,
            elevation: 0,
            onPressed: () {
              _index < pages.length - 1 ? _index++ : _index = 0;
              _tabController.animateTo(_index);
            },
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
