import 'package:flutter/material.dart';
import 'package:mark_manager/entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark_manager/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
      ),
      home: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: IconButton.outlined(
                    onPressed: () {
                      ref.read(entityDataProvider.notifier).add(Subject(
                            title: "Subject",
                            examMarks: const [],
                            testMarks: [],
                          ));
                    },
                    icon: const Icon(Icons.add)),
              ),
              
            ],
          ),
          body: ListView(
            children: [
              for (var entity in ref.watch(entityDataProvider)) entity
            ],
          )),
    );
  }
}
