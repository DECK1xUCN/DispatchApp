import 'package:flutter/material.dart';

class Dfr extends StatefulWidget {
  const Dfr({Key? key}) : super(key: key);

  @override
  _DfrState createState() => _DfrState();
}

class _DfrState extends State<Dfr> {
  List<List<String>> lists = [
    ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7'],
    ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7'],
    ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7'],
    ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7'],
    ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7'],
    ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7'],
    ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(height: 30),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'DFR',
              style: TextStyle(
                  fontSize: 30, color: Colors.black, fontFamily: 'Roboto'),
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: lists.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Table(
                      defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                      children: const [
                        TableRow(
                          children: [
                            TableCell(
                                child: Text('Id',
                                    style: TextStyle(color: Colors.black))),
                            TableCell(
                                child: Text('A/C Model',
                                    style: TextStyle(color: Colors.black))),
                            TableCell(
                                child: Text('A/C Registration',
                                    style: TextStyle(color: Colors.black))),
                            TableCell(
                                child: Text('Column 4',
                                    style: TextStyle(color: Colors.black))),
                            TableCell(
                                child: Text('Column 5',
                                    style: TextStyle(color: Colors.black))),
                            TableCell(
                                child: Text('Column 6',
                                    style: TextStyle(color: Colors.black))),
                            TableCell(
                                child: Text('Column 7',
                                    style: TextStyle(color: Colors.black))),
                          ],
                        ),
                      ],
                    );
                  }
                  final currentList = lists[index - 1];
                  final rowData = currentList[index - 1];
                  return Table(
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                              child: Text(rowData,
                                  style: TextStyle(color: Colors.black))),
                          TableCell(
                              child: Text(rowData,
                                  style: TextStyle(color: Colors.black))),
                          TableCell(
                              child: Text(rowData,
                                  style: TextStyle(color: Colors.black))),
                          TableCell(
                              child: Text(rowData,
                                  style: TextStyle(color: Colors.black))),
                          TableCell(
                              child: Text(rowData,
                                  style: TextStyle(color: Colors.black))),
                          TableCell(
                              child: Text(rowData,
                                  style: TextStyle(color: Colors.black))),
                          TableCell(
                              child: Text(rowData,
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        )
      ],
      ),
    );
  }
}