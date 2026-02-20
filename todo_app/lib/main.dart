import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cumbinitu',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const MyHomePage(title: 'Cumbinitu?'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todoList = [];

  final TextEditingController _controller = TextEditingController();

  int updateIndex = -1;

  void addList(String task) {
    setState(() {
      todoList.add(task);
      _controller.clear();
    });
  }

  void updateListItem(String task, int index) {
    setState(() {
      todoList[index] = task;

      updateIndex = -1;
      _controller.clear();
    });
  }

  void deleteItem(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
          ),
          centerTitle: false,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),

                    color: Colors.green,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex:80,
                            child: Text(
                              //Display task text
                              todoList[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                              ),
                          ),
                          //Edit button
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                                _controller.text = todoList[index];
                                updateIndex = index;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          //Delete button
                          IconButton(
                            onPressed: () {
                              deleteItem(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    )
                  );
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 70,
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              )),
                            filled: true,

                            labelText: 'Crea nuovo task...',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ),
                  ),
                FloatingActionButton(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              
              onPressed: () {
                assert(_controller.text != '', );
                updateIndex != -1 ? updateListItem(_controller.text, updateIndex) : addList(_controller.text);
              },
              child: Icon(updateIndex != -1 ? Icons.edit : Icons.add),
            ),
                ],
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
