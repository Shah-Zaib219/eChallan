import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChallanModel {
  final String cnic;
  final String fine;
  final String licence;
  final String name;
  final String paymentStatus;
  final String phone;
  final String vehicleNo;
  final String challanBy;
  String? officerFirstName;
  String? officerLastName;
  String? officerId;
  final String challanTime;

  ChallanModel({
    required this.cnic,
    required this.fine,
    required this.licence,
    required this.name,
    required this.paymentStatus,
    required this.phone,
    required this.vehicleNo,
    required this.challanBy,
    this.officerFirstName,
    this.officerLastName,
    this.officerId,
    required this.challanTime,
  });

  factory ChallanModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    Timestamp timestamp = data['challan_time'] ?? Timestamp.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(timestamp.toDate());
    return ChallanModel(
      cnic: data['cnic'] ?? '',
      fine: data['fine'] ?? '',
      licence: data['licence'] ?? '',
      name: data['name'] ?? '',
      paymentStatus: data['payment_status'] ?? '',
      phone: data['phone'] ?? '',
      vehicleNo: data['vehicle_no'] ?? '',
      challanBy: data['challan_by'] ?? '',
      challanTime: formattedDate,
    );
  }

  Future<void> fetchOfficerDetails() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(challanBy)
          .get();

      if (userDoc.exists) {
        officerFirstName = userDoc['first_name'] ?? '';
        officerLastName = userDoc['last_name'] ?? '';
        officerId = userDoc['id'] ?? '';
      } else {
        print("Officer document does not exist.");
      }
    } catch (e) {
      print("Error fetching officer details: $e");
    }
  }
}
