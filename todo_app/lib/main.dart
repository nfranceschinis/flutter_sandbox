import 'package:flutter/material.dart';

class Entry {
  const Entry({required this.name});

  final String name;
}

typedef ListChangedCallback = void Function(Entry entry, bool isDone);

class ToDoListItem extends StatelessWidget {
  ToDoListItem({
    required this.entry,
    required this.isDone,
    required this.onToDoListChanged,
  }) : super(key: ObjectKey(entry));

  final Entry entry;
  final bool isDone;
  final ListChangedCallback onToDoListChanged;

  Color _getColor(BuildContext context) {
    return isDone ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!isDone) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap:() {
        onToDoListChanged(entry, isDone);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(entry.name[0]),
      ),
      title: Text(entry.name, style: _getTextStyle(context)),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({required this.entries, super.key});

  final List<Entry> entries;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final _todoList = <Entry> {};

  void _handleToDoListChanged(Entry entry, bool isDone) {
    setState(() {
      if (!isDone) {
        _todoList.add(entry);
      } else {
        _todoList.remove(entry);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ce ti coventie?')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: widget.entries.map((entry) {
          return ToDoListItem(
            entry: entry,
            isDone: _todoList.contains(entry),
            onToDoListChanged: _handleToDoListChanged,
          );
        }).toList(),
      ),
    );
  }
}
void main() {
  runApp(
    const MaterialApp(
      title: 'Ce ti coventie?',
      home: Center(child:ToDoList(
        entries: [
          Entry(name: 'test1'),
          Entry(name: 'test2'),
          Entry(name: 'test3'),
        ],
      ),),
    ),
  );
}