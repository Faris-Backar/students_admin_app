import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 90.h, width: 100.w, child: const DataTable2Demo());
  }
}

class DataTable2Demo extends StatefulWidget {
  const DataTable2Demo({super.key});

  @override
  DataTable2DemoState createState() => DataTable2DemoState();
}

class DataTable2DemoState extends State<DataTable2Demo> {
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late DessertDataSource _dessertsDataSource;
  bool _initialized = false;
  bool showCustomArrow = false;
  bool sortArrowsAlwaysVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final currentRouteOption = getCurrentRouteOption(context);
      _dessertsDataSource = DessertDataSource(
          context,
          false,
          currentRouteOption == rowTaps,
          currentRouteOption == rowHeightOverrides,
          currentRouteOption == showBordersWithZebraStripes);
      _initialized = true;
      _dessertsDataSource.addListener(() {
        setState(() {});
      });
    }
  }

  void _sort<T>(
    Comparable<T> Function(Dessert d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _dessertsDataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const alwaysShowArrows = false;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Theme(
          // Using themes to override scroll bar appearence, note that iOS scrollbars do not support color overrides
          data: ThemeData(
              iconTheme: const IconThemeData(color: Colors.white),
              scrollbarTheme: ScrollbarThemeData(
                thickness: WidgetStateProperty.all(5),
                // thumbVisibility: MaterialStateProperty.all(true),
                // thumbColor: MaterialStateProperty.all<Color>(Colors.yellow)
              )),
          child: DataTable2(
            // Forcing all scrollbars to be visible, alternatively themes can be used (see above)
            headingRowColor:
                WidgetStateColor.resolveWith((states) => Colors.grey[850]!),
            headingTextStyle: const TextStyle(color: Colors.white),
            headingCheckboxTheme: const CheckboxThemeData(
                side: BorderSide(color: Colors.white, width: 2.0)),
            //checkboxAlignment: Alignment.topLeft,
            isHorizontalScrollBarVisible: true,
            isVerticalScrollBarVisible: true,
            columnSpacing: 12,
            horizontalMargin: 12,
            sortArrowBuilder: getCurrentRouteOption(context) == custArrows
                ? (ascending, sorted) => sorted || alwaysShowArrows
                    ? Stack(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: _SortIcon(
                                  ascending: true,
                                  active: sorted && ascending)),
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: _SortIcon(
                                  ascending: false,
                                  active: sorted && !ascending)),
                        ],
                      )
                    : null
                : null,
            border: getCurrentRouteOption(context) == fixedColumnWidth
                ? TableBorder(
                    top: const BorderSide(color: Colors.black),
                    bottom: BorderSide(color: Colors.grey[300]!),
                    left: BorderSide(color: Colors.grey[300]!),
                    right: BorderSide(color: Colors.grey[300]!),
                    verticalInside: BorderSide(color: Colors.grey[300]!),
                    horizontalInside:
                        const BorderSide(color: Colors.grey, width: 1))
                : (getCurrentRouteOption(context) == showBordersWithZebraStripes
                    ? TableBorder.all()
                    : null),
            dividerThickness:
                1, // this one will be ignored if [border] is set above
            bottomMargin: 10,
            minWidth: 900,
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
            sortArrowAnimationDuration:
                const Duration(milliseconds: 500), // custom animation duration
            onSelectAll: (val) =>
                setState(() => _dessertsDataSource.selectAll(val)),
            columns: [
              DataColumn2(
                label: const Text('Desert'),
                size: ColumnSize.S,
                // example of fixed 1st row
                fixedWidth: getCurrentRouteOption(context) == fixedColumnWidth
                    ? 200
                    : null,
                onSort: (columnIndex, ascending) =>
                    _sort<String>((d) => d.name, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Calories'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((d) => d.calories, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Fat (gm)'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((d) => d.fat, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Carbs (gm)'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((d) => d.carbs, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Protein (gm)'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((d) => d.protein, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Sodium (mg)'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((d) => d.sodium, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Calcium (%)'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((d) => d.calcium, columnIndex, ascending),
              ),
              DataColumn2(
                label: const Text('Iron (%)'),
                size: ColumnSize.S,
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((d) => d.iron, columnIndex, ascending),
              ),
            ],
            empty: Center(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.grey[200],
                    child: const Text('No data'))),
            rows: getCurrentRouteOption(context) == noData
                ? []
                : List<DataRow>.generate(_dessertsDataSource.rowCount,
                    (index) => _dessertsDataSource.getRow(index)),
          )),
    );
  }
}

class _SortIcon extends StatelessWidget {
  final bool ascending;
  final bool active;

  const _SortIcon({required this.ascending, required this.active});

  @override
  Widget build(BuildContext context) {
    return Icon(
      ascending ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
      size: 28,
      color: active ? Colors.cyan : null,
    );
  }
}

/// Route options are used to configure certain features of
/// the given example
String getCurrentRouteOption(BuildContext context) {
  var isEmpty = ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.arguments != null &&
          ModalRoute.of(context)!.settings.arguments is String
      ? ModalRoute.of(context)!.settings.arguments as String
      : '';

  return isEmpty;
}

// Route options
const dflt = 'Default';
const noData = 'No data';
const autoRows = 'Auto rows';
const showBordersWithZebraStripes = 'Borders with Zebra';
const custPager = 'Custom pager';
const defaultSorting = 'Default sorting';
const selectAllPage = 'Select all at page';
const rowTaps = 'Row Taps';
const rowHeightOverrides = 'Row height overrides';
const fixedColumnWidth = 'Fixed column width';
const dataTable2 = 'DataTable2';
const paginatedFixedRowsCols = 'PaginatedDataTable2';
const asyncPaginatedFixedRowsCols = 'AsyncPaginatedDataTable2';
const custArrows = 'Custom sort arrows';
const asyncErrors =
    "Errors/Retries"; // Async sample that emulates network error and allow retrying load operation
const goToLast =
    "Start at last page"; // Used by async example, navigates to the very last page upon opening the screen
const rounded = 'Rounded style';

/// Configurations available to given example routes
const Map<String, List<String>> routeOptions = {
  '/datatable2': [
    dflt,
    noData,
    showBordersWithZebraStripes,
    fixedColumnWidth,
    rowTaps,
    rowHeightOverrides,
    custArrows,
    rounded
  ],
  '/paginated2': [dflt, noData, autoRows, custPager, defaultSorting],
  '/datatable2fixedmn': [
    dataTable2,
    paginatedFixedRowsCols,
    asyncPaginatedFixedRowsCols
  ],
  '/asyncpaginated2': [
    dflt,
    noData,
    selectAllPage,
    autoRows,
    asyncErrors,
    goToLast,
    custPager
  ],
};

List<String>? getOptionsForRoute(String route) {
  if (!routeOptions.containsKey(route)) {
    return null;
  }

  return routeOptions[route];
}

// ignore_for_file: avoid_print
// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

/// Keeps track of selected rows, feed the data into DesertsDataSource
class RestorableDessertSelections extends RestorableProperty<Set<int>> {
  Set<int> _dessertSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dessertSelections.contains(index);

  /// Takes a list of [Dessert]s and saves the row indices of selected rows
  /// into a [Set].
  void setDessertSelections(List<Dessert> desserts) {
    final updatedSet = <int>{};
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (dessert.selected) {
        updatedSet.add(i);
      }
    }
    _dessertSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dessertSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dessertSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dessertSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dessertSelections = value;
  }

  @override
  Object toPrimitives() => _dessertSelections.toList();
}

int _idCounter = 0;

/// Domain model entity
class Dessert {
  Dessert(
    this.name,
    this.calories,
    this.fat,
    this.carbs,
    this.protein,
    this.sodium,
    this.calcium,
    this.iron,
  );

  final int id = _idCounter++;

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;
  bool selected = false;
}

/// Data source implementing standard Flutter's DataTableSource abstract class
/// which is part of DataTable and PaginatedDataTable synchronous data fecthin API.
/// This class uses static collection of deserts as a data store, projects it into
/// DataRows, keeps track of selected items, provides sprting capability
class DessertDataSource extends DataTableSource {
  DessertDataSource.empty(this.context) {
    desserts = [];
  }

  DessertDataSource(this.context,
      [sortedByCalories = false,
      this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]) {
    desserts = _desserts;
    if (sortedByCalories) {
      sort((d) => d.calories, true);
    }
  }

  final BuildContext context;
  late List<Dessert> desserts;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(Dessert d) getField, bool ascending) {
    desserts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void updateSelectedDesserts(RestorableDessertSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (selectedRows.isSelected(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow2 getRow(int index, [Color? color]) {
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= desserts.length) throw 'index > _desserts.length';
    final dessert = desserts[index];
    return DataRow2.byIndex(
      index: index,
      selected: dessert.selected,
      color: color != null
          ? WidgetStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? WidgetStateProperty.all(Theme.of(context).highlightColor)
              : null),
      onSelectChanged: (value) {
        if (dessert.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      onTap: hasRowTaps
          ? () => _showSnackbar(context, 'Tapped on row ${dessert.name}')
          : null,
      onDoubleTap: hasRowTaps
          ? () => _showSnackbar(context, 'Double Tapped on row ${dessert.name}')
          : null,
      onLongPress: hasRowTaps
          ? () => _showSnackbar(context, 'Long pressed on row ${dessert.name}')
          : null,
      onSecondaryTap: hasRowTaps
          ? () => _showSnackbar(context, 'Right clicked on row ${dessert.name}')
          : null,
      onSecondaryTapDown: hasRowTaps
          ? (d) =>
              _showSnackbar(context, 'Right button down on row ${dessert.name}')
          : null,
      specificRowHeight:
          hasRowHeightOverrides && dessert.fat >= 25 ? 100 : null,
      cells: [
        DataCell(Text(dessert.name)),
        DataCell(Text('${dessert.calories}'),
            onTap: () => _showSnackbar(context,
                'Tapped on a cell with "${dessert.calories}"', Colors.red)),
        DataCell(Text(dessert.fat.toStringAsFixed(1))),
        DataCell(Text('${dessert.carbs}')),
        DataCell(Text(dessert.protein.toStringAsFixed(1))),
        DataCell(Text('${dessert.sodium}')),
        DataCell(Text(format.format(dessert.calcium / 100))),
        DataCell(Text(format.format(dessert.iron / 100))),
      ],
    );
  }

  @override
  int get rowCount => desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final dessert in desserts) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? desserts.length : 0;
    notifyListeners();
  }
}

/// Async datasource for AsynPaginatedDataTabke2 example. Based on AsyncDataTableSource which
/// is an extension to Flutter's DataTableSource and aimed at solving
/// saync data fetching scenarious by paginated table (such as using Web API)
class DessertDataSourceAsync extends AsyncDataTableSource {
  DessertDataSourceAsync() {
    print('DessertDataSourceAsync created');
  }

  DessertDataSourceAsync.empty() {
    _empty = true;
    print('DessertDataSourceAsync.empty created');
  }

  DessertDataSourceAsync.error() {
    _errorCounter = 0;
    print('DessertDataSourceAsync.error created');
  }

  bool _empty = false;
  int? _errorCounter;

  RangeValues? _caloriesFilter;

  RangeValues? get caloriesFilter => _caloriesFilter;
  set caloriesFilter(RangeValues? calories) {
    _caloriesFilter = calories;
    refreshDatasource();
  }

  final DesertsFakeWebService _repo = DesertsFakeWebService();

  String _sortColumn = "name";
  bool _sortAscending = true;

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    refreshDatasource();
  }

  Future<int> getTotalRecords() {
    return Future<int>.delayed(
        const Duration(milliseconds: 0), () => _empty ? 0 : _dessertsX3.length);
  }

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    print('getRows($startIndex, $count)');
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(startIndex >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var x = _empty
        ? await Future.delayed(const Duration(milliseconds: 2000),
            () => DesertsFakeWebServiceResponse(0, []))
        : await _repo.getData(
            startIndex, count, _caloriesFilter, _sortColumn, _sortAscending);

    var r = AsyncRowsResponse(
        x.totalRecords,
        x.data.map((dessert) {
          return DataRow(
            key: ValueKey<int>(dessert.id),
            //selected: dessert.selected,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(ValueKey<int>(dessert.id), value);
              }
            },
            cells: [
              DataCell(Text(dessert.name)),
              DataCell(Text('${dessert.calories}')),
              DataCell(Text(dessert.fat.toStringAsFixed(1))),
              DataCell(Text('${dessert.carbs}')),
              DataCell(Text(dessert.protein.toStringAsFixed(1))),
              DataCell(Text('${dessert.sodium}')),
              DataCell(Text(format.format(dessert.calcium / 100))),
              DataCell(Text(format.format(dessert.iron / 100))),
            ],
          );
        }).toList());

    return r;
  }
}

class DesertsFakeWebServiceResponse {
  DesertsFakeWebServiceResponse(this.totalRecords, this.data);

  /// THe total ammount of records on the server, e.g. 100
  final int totalRecords;

  /// One page, e.g. 10 reocrds
  final List<Dessert> data;
}

class DesertsFakeWebService {
  int Function(Dessert, Dessert)? _getComparisonFunction(
      String column, bool ascending) {
    var coef = ascending ? 1 : -1;
    switch (column) {
      case 'name':
        return (Dessert d1, Dessert d2) => coef * d1.name.compareTo(d2.name);
      case 'calories':
        return (Dessert d1, Dessert d2) => coef * (d1.calories - d2.calories);
      case 'fat':
        return (Dessert d1, Dessert d2) => coef * (d1.fat - d2.fat).round();
      case 'carbs':
        return (Dessert d1, Dessert d2) => coef * (d1.carbs - d2.carbs);
      case 'protein':
        return (Dessert d1, Dessert d2) =>
            coef * (d1.protein - d2.protein).round();
      case 'sodium':
        return (Dessert d1, Dessert d2) => coef * (d1.sodium - d2.sodium);
      case 'calcium':
        return (Dessert d1, Dessert d2) => coef * (d1.calcium - d2.calcium);
      case 'iron':
        return (Dessert d1, Dessert d2) => coef * (d1.iron - d2.iron);
    }

    return null;
  }

  Future<DesertsFakeWebServiceResponse> getData(int startingAt, int count,
      RangeValues? caloriesFilter, String sortedBy, bool sortedAsc) async {
    return Future.delayed(
        Duration(
            milliseconds: startingAt == 0
                ? 2650
                : startingAt < 20
                    ? 2000
                    : 400), () {
      var result = _dessertsX3;

      if (caloriesFilter != null) {
        result = result
            .where((e) =>
                e.calories >= caloriesFilter.start &&
                e.calories <= caloriesFilter.end)
            .toList();
      }

      result.sort(_getComparisonFunction(sortedBy, sortedAsc));
      return DesertsFakeWebServiceResponse(
          result.length, result.skip(startingAt).take(count).toList());
    });
  }
}

int _selectedCount = 0;

List<Dessert> _desserts = <Dessert>[
  Dessert(
    'Frozen Yogurt',
    159,
    6.0,
    24,
    4.0,
    87,
    14,
    1,
  ),
  Dessert(
    'Ice Cream Sandwich',
    237,
    9.0,
    37,
    4.3,
    129,
    8,
    1,
  ),
  Dessert(
    'Eclair',
    262,
    16.0,
    24,
    6.0,
    337,
    6,
    7,
  ),
  Dessert(
    'Cupcake',
    305,
    3.7,
    67,
    4.3,
    413,
    3,
    8,
  ),
  Dessert(
    'Gingerbread',
    356,
    16.0,
    49,
    3.9,
    327,
    7,
    16,
  ),
  Dessert(
    'Jelly Bean',
    375,
    0.0,
    94,
    0.0,
    50,
    0,
    0,
  ),
  Dessert(
    'Lollipop',
    392,
    0.2,
    98,
    0.0,
    38,
    0,
    2,
  ),
  Dessert(
    'Honeycomb',
    408,
    3.2,
    87,
    6.5,
    562,
    0,
    45,
  ),
  Dessert(
    'Donut',
    452,
    25.0,
    51,
    4.9,
    326,
    2,
    22,
  ),
  Dessert(
    'Apple Pie',
    518,
    26.0,
    65,
    7.0,
    54,
    12,
    6,
  ),
  Dessert(
    'Frozen Yougurt with sugar',
    168,
    6.0,
    26,
    4.0,
    87,
    14,
    1,
  ),
  Dessert(
    'Ice Cream Sandwich with sugar',
    246,
    9.0,
    39,
    4.3,
    129,
    8,
    1,
  ),
  Dessert(
    'Eclair with sugar',
    271,
    16.0,
    26,
    6.0,
    337,
    6,
    7,
  ),
  Dessert(
    'Cupcake with sugar',
    314,
    3.7,
    69,
    4.3,
    413,
    3,
    8,
  ),
  Dessert(
    'Gingerbread with sugar',
    345,
    16.0,
    51,
    3.9,
    327,
    7,
    16,
  ),
  Dessert(
    'Jelly Bean with sugar',
    364,
    0.0,
    96,
    0.0,
    50,
    0,
    0,
  ),
  Dessert(
    'Lollipop with sugar',
    401,
    0.2,
    100,
    0.0,
    38,
    0,
    2,
  ),
  Dessert(
    'Honeycomd with sugar',
    417,
    3.2,
    89,
    6.5,
    562,
    0,
    45,
  ),
  Dessert(
    'Donut with sugar',
    461,
    25.0,
    53,
    4.9,
    326,
    2,
    22,
  ),
  Dessert(
    'Apple pie with sugar',
    527,
    26.0,
    67,
    7.0,
    54,
    12,
    6,
  ),
  Dessert(
    'Forzen yougurt with honey',
    223,
    6.0,
    36,
    4.0,
    87,
    14,
    1,
  ),
  Dessert(
    'Ice Cream Sandwich with honey',
    301,
    9.0,
    49,
    4.3,
    129,
    8,
    1,
  ),
  Dessert(
    'Eclair with honey',
    326,
    16.0,
    36,
    6.0,
    337,
    6,
    7,
  ),
  Dessert(
    'Cupcake with honey',
    369,
    3.7,
    79,
    4.3,
    413,
    3,
    8,
  ),
  Dessert(
    'Gignerbread with hone',
    420,
    16.0,
    61,
    3.9,
    327,
    7,
    16,
  ),
  Dessert(
    'Jelly Bean with honey',
    439,
    0.0,
    106,
    0.0,
    50,
    0,
    0,
  ),
  Dessert(
    'Lollipop with honey',
    456,
    0.2,
    110,
    0.0,
    38,
    0,
    2,
  ),
  Dessert(
    'Honeycomd with honey',
    472,
    3.2,
    99,
    6.5,
    562,
    0,
    45,
  ),
  Dessert(
    'Donut with honey',
    516,
    25.0,
    63,
    4.9,
    326,
    2,
    22,
  ),
  Dessert(
    'Apple pie with honey',
    582,
    26.0,
    77,
    7.0,
    54,
    12,
    6,
  ),
];

List<Dessert> _dessertsX3 = _desserts.toList()
  ..addAll(_desserts.map((i) => Dessert('${i.name} x2', i.calories, i.fat,
      i.carbs, i.protein, i.sodium, i.calcium, i.iron)))
  ..addAll(_desserts.map((i) => Dessert('${i.name} x3', i.calories, i.fat,
      i.carbs, i.protein, i.sodium, i.calcium, i.iron)));

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
