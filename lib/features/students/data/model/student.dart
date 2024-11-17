import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app_admin/features/students/domain/model/students_entity.dart';

class Student extends StudentEntity {
  Student(
      {required super.batch,
      required super.college,
      required super.createdAt,
      required super.department,
      required super.email,
      required super.fullName,
      required super.mobileNumber,
      required super.proPic,
      required super.semester,
      required super.uuid,
      required super.year});

  // Factory constructor to create a StudentEntity from Firestore document
  factory Student.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Student(
      batch: data['batch'] ?? '',
      college: data['college'] ?? '',
      createdAt: (data['createdAt'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
      department: data['department'] ?? '',
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      mobileNumber: data['mobileNumber'] ?? '',
      proPic: data['proPic'] ?? '',
      semester: data['semester'] ?? '',
      uuid: data['uuid'] ?? '',
      year: data['year'] ?? 0,
    );
  }

  // Method to convert StudentEntity to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'batch': batch,
      'college': college,
      'createdAt':
          Timestamp.fromDate(createdAt), // Convert DateTime to Timestamp
      'department': department,
      'email': email,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'proPic': proPic,
      'semester': semester,
      'uuid': uuid,
      'year': year,
    };
  }
}
