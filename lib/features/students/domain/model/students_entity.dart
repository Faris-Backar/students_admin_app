class StudentEntity {
  final String batch;
  final String college;
  final DateTime createdAt; // Timestamp will be converted to DateTime
  final String department;
  final String email;
  final String fullName;
  final String mobileNumber;
  final String proPic;
  final String semester;
  final String uuid;
  final int year;

  StudentEntity({
    required this.batch,
    required this.college,
    required this.createdAt,
    required this.department,
    required this.email,
    required this.fullName,
    required this.mobileNumber,
    required this.proPic,
    required this.semester,
    required this.uuid,
    required this.year,
  });
}
