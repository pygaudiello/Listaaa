import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = []; // Lista 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true, // Título centralizado
        backgroundColor: const Color.fromARGB(255, 170, 235, 255),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(
            task: tasks[index],
            onDelete: () {
              _deleteTask(index);
            },
            onToggle: () {
              _toggleTask(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        child: const Icon(Icons.event),
        backgroundColor:
            const Color.fromARGB(255, 170, 235, 255), 
      ),
    );
  }

  void _addTask(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Tarefa'),
          content: TextField(
            controller: taskController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(title: taskController.text, completed: false));
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 170, 235, 255),
              ),
              child: const Text('Adicionar'),
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

  void _toggleTask(int index) {
    setState(() {
      tasks[index].toggleCompleted();
    });
  }
}

class Task {
  String title;
  bool completed;

  Task({required this.title, required this.completed});

  void toggleCompleted() {
    completed = !completed;
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TaskItem({
    required this.task,
    required this.onDelete,
    required this.onToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (value) {
          onToggle();
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          fontSize: 15,
          decoration: task.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}

