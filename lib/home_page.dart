import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/list_provider.dart';
import 'models/model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _formKey;
  TextEditingController _controller;
  var taskItems;
  int counter = 0;
  Groceries listClass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formKey = GlobalKey();
    _controller = TextEditingController();
    taskItems = Provider.of<ListProvider>(context, listen: false);
    listClass = Groceries(taskItems.list);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _controller,
                    key: _formKey,
                    onSaved: (val) {
                      taskItems.addItem(val);
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        hintText: 'Ürün'),
                  )),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        hintText: 'Fiyat'),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                  child: Text('Kaydet'),
                ),
              ),
              Consumer<ListProvider>(builder: (context, provider, listTile) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: listClass.list.length,
                    itemBuilder: buildList,
                  ),
                );
              }),
            ],
          ),
        ));
  }

  Widget buildList(BuildContext context, int index) {
    counter++;
    return Dismissible(
        key: Key(counter.toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          taskItems.deleteItem(index);
        },
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Text(listClass.list[index].toString()),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ));
  }
}
