import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class DataTableWidget<T> extends StatefulWidget {
  final List<T> data;
  final List<String> columns;
  final List<String> Function(T) getRowData;
  final Function(T) onRowSelected;

  const DataTableWidget({
    super.key,
    required this.data,
    required this.columns,
    required this.getRowData,
    required this.onRowSelected,
  });

  @override
  _DataTableWidgetState<T> createState() => _DataTableWidgetState<T>();
}

class _DataTableWidgetState<T> extends State<DataTableWidget<T>> {
  String _searchTerm = '';

  List<T> get filteredData {
    return widget.data.where((item) {
      return widget.getRowData(item).any((value) =>
          value.toString().toLowerCase().contains(_searchTerm.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: widget.columns
            .map((col) => DataColumn2(label: Text(col), size: ColumnSize.L))
            .toList(),
        rows: filteredData.map((item) {
          return DataRow(
            onSelectChanged: (selected) => widget.onRowSelected(item),
            cells: widget
                .getRowData(item)
                .map((data) => DataCell(Text(data.toString())))
                .toList(),
          );
        }).toList(),
      ),
    );
  }
}
