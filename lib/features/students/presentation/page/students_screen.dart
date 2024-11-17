import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:student_app_admin/features/students/presentation/providers/student_providers.dart';
import 'package:student_app_admin/gen/fonts.gen.dart';

@RoutePage()
class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger fetchStudents when the screen initializes.
    Future.microtask(() {
      ref.read(studentProvider.notifier).fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);

    return SizedBox(
      height: 90.h,
      width: 100.w,
      child: studentState.map(
        initial: (_) => const Center(child: Text("Welcome! Loading data...")),
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (error) => Center(child: Text('Error: ${error.message}')),
        loaded: (data) {
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
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey[850]!),
                headingTextStyle: const TextStyle(
                    color: Colors.white, fontFamily: FontFamily.poppins),
                headingCheckboxTheme: const CheckboxThemeData(
                    side: BorderSide(color: Colors.white, width: 2.0)),
                border: TableBorder.all(),
                dividerThickness: 1,
                bottomMargin: 10,
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: Text("Sl. No"),
                    size: ColumnSize.S, // Adjust to fit smaller content
                  ),
                  DataColumn2(
                    label: Text("Full Name"),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text("Email"),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text("Mobile Number"),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text("Batch"),
                    size: ColumnSize.M, // Adjust dynamically to medium size
                  ),
                  DataColumn2(
                    label: Text("College"),
                    size: ColumnSize.L, // Adjust dynamically to large size
                  ),
                  DataColumn2(
                    label: Text("Department"),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text("Profile Pic"),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text("Semester"),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Text("Year"),
                    size: ColumnSize.S,
                  ),
                ],
                rows: data.students.asMap().entries.map((entry) {
                  final index = entry.key + 1; // Calculate serial number
                  final student = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(Text(index.toString())), // Serial Number
                      DataCell(Text(student.fullName)),
                      DataCell(Text(student.email)),
                      DataCell(Text(student.mobileNumber)),
                      DataCell(Text(student.batch)),
                      DataCell(Text(student.college)),
                      DataCell(Text(student.department)),
                      DataCell(
                        student.proPic.isNotEmpty
                            ? CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Image.network(
                                    student.proPic,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.broken_image,
                                          color: Colors.grey);
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                              )
                            : const Text("No Image"),
                      ),
                      DataCell(Text(student.semester)),
                      DataCell(Text(student.year.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
