import 'package:flutter/material.dart';

import '../services/preferences_list.dart';
import '../widgets/todo_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    PreferencesList().readTodoPref().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notas'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                var todo = todoList[index];
                return Column(
                  children: [
                    Text(
                      todo.titulo,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(todo.fecha),
                    Text(todo.cuerpo),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoPopupWidget(context).then((_) => PreferencesList().writeTodoPref()).then((_) => setState(() {}));
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
