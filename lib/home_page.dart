import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerTitulo = TextEditingController();

  final repository = DataRepository();

  void _adicionar() async {
    await repository.create(
      titulo: _controllerTitulo.text,
    );
    _controllerTitulo.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Flexible(
            child: TextFormField(controller: _controllerTitulo),
          ),
          Flexible(
            flex: 3,
            child: StreamBuilder<QuerySnapshot>(
                stream: repository.getAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final listData = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        final item = listData[index];
                        return ListTile(
                          title: Text(item['titulo']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              repository.delete(idDocument: item.id);
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionar,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
