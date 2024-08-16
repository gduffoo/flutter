import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: SplitView(
        viewMode: SplitViewMode.Vertical,
        indicator: const SplitIndicator(viewMode: SplitViewMode.Vertical),
        activeIndicator: const SplitIndicator(
          viewMode: SplitViewMode.Vertical,
          isActive: true,
        ),
        controller: SplitViewController(limits: [null, WeightLimit(max: 0.5)]),
        onWeightChanged: (w) => print("Vertical $w"),
        children: [
          SplitView(
            viewMode: SplitViewMode.Horizontal,
            indicator: const SplitIndicator(viewMode: SplitViewMode.Horizontal),
            activeIndicator: const SplitIndicator(
              viewMode: SplitViewMode.Horizontal,
              isActive: true,
            ),
            children: [
              Container(
                color: Colors.red,
                child: const Center(child: Text("View1")),
              ),
              Container(
                color: Colors.blue,
                child: const Center(child: Text("View2")),
              ),
              Container(
                color: Colors.green,
                child: const Center(child: Text("View3")),
              ),
            ],
            onWeightChanged: (w) => print("Horizon: $w"),
          ),
          Container(
            color: Colors.purple,
            child: const Center(child: Text("View4")),
          ),
          Container(
            color: Colors.yellow,
            child: const Center(child: Text("View5")),
          ),
        ],
      ),
    );
  }
}
