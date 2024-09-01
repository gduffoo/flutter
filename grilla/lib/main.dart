import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Grilla de ejemplo',
      home: DataTableExample(),
    );
  }
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final List<Map<String, dynamic>> _data = [
    {'nombre': 'Juan', 'edad': 25},
    {'nombre': 'Ana', 'edad': 30},
    {'nombre': 'Pedro', 'edad': 22},
    {'nombre': 'Maria', 'edad': 28},
  ];

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredData = _data.where((item) {
      return item['nombre']
          .toString()
          .toLowerCase()
          .contains(_searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grilla con Filtrado y Ordenado'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(
                    label: const Text('Nombre'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        if (ascending) {
                          filteredData.sort(
                              (a, b) => a['nombre'].compareTo(b['nombre']));
                        } else {
                          filteredData.sort(
                              (a, b) => b['nombre'].compareTo(a['nombre']));
                        }
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('Edad'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        if (ascending) {
                          filteredData
                              .sort((a, b) => a['edad'].compareTo(b['edad']));
                        } else {
                          filteredData
                              .sort((a, b) => b['edad'].compareTo(a['edad']));
                        }
                      });
                    },
                  ),
                ],
                rows: filteredData.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item['nombre'])),
                    DataCell(Text(item['edad'].toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
