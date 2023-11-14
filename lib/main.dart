import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> tasks = []; // Lista de Compromissos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compromissos'),
        centerTitle: true, // Título centralizado
        backgroundColor: Colors.red, //AppBar vermelha
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteTask(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        child: Icon(Icons.event),
        backgroundColor: Colors.red, // Botão vermelho
      ),
    );
  }

  void _addTask(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Compromisso'),
          content: TextField(
            controller: taskController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add(taskController.text);
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, //Adicionar em vermelho
              ),
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }
}
