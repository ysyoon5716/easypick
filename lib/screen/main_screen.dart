import 'dart:math';
import 'package:flutter/material.dart';

import 'package:EasyPick/model/option.dart';
import 'package:EasyPick/component/table_cell.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Option> options = [
    Option(id: '1', name: '짜장면', weight: 10),
    Option(id: '2', name: '짬뽕', weight: 5)
  ];

  void addOption(String name, int weight) {
    setState(() {
      var id = DateTime.now().microsecondsSinceEpoch.toString();
      options.add(Option(id: id, name: name, weight: weight));
    });
  }

  void changeOption(String id, String name, int weight) {
    setState(() {
      int index = options.indexWhere((option) => option.id == id);
      options[index] = Option(id: id, name: name, weight: weight);
    });
  }

  void deleteOption(String id) {
    setState(() {
      options.removeWhere((option) => option.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('EasyPick')
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Table(
                key: Key(options.length.toString()),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1)
                },
                children: [
                  TableRow(
                    children: [
                      HeaderCell(text: 'option'),
                      HeaderCell(text: 'weight'),
                      HeaderCell(text: '')
                    ]
                  ),
                  ...List.generate(
                    options.length,
                    (index) {
                      var option = options[index];
                      return TableRow(
                        children: [
                          TextFormCell(text: option.name, onChanged: (value) => changeOption(option.id, value, option.weight)),
                          TextFormCell(text: option.weight.toString(), onChanged: (value) => changeOption(option.id, option.name, int.parse(value))),
                          IconCell(icon: Icons.delete, onPressed: () => deleteOption(option.id))
                        ]
                      );
                    }
                  )
                ],
              )
            ]
          )
        )
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,            
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                addOption('새로운 옵션', 1);
              },
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                Option option = selectOption(options);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('선택 결과'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(option.name, style: TextStyle(fontSize: 20))
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                }, 
                                child: Text('Accept'),
                                style: TextButton.styleFrom(foregroundColor: Colors.blue)
                              ),
                              TextButton(
                                onPressed: () {                                  
                                  deleteOption(option.id);
                                  Navigator.pop(context);
                                },
                                child: Text('Reject'),
                                style: TextButton.styleFrom(foregroundColor: Colors.red,)
                              )
                            ]
                          )
                        ],
                      )
                    );
                  }
                );
              },
            )
          )
        ]
      )
    );
  }
}

selectOption (List<Option> options) {
  int totalWeight = 0;
  for (Option option in options) {
    totalWeight += option.weight;
  };
  
  int current = 0;
  int random = Random().nextInt(totalWeight);
  
  for (int i = 0; i < options.length; i++) {
    var option = options[i];
    current += option.weight;
    if (random < current) {
      return option;
    };
  };
}