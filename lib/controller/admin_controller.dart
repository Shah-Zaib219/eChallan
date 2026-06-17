import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/model/challan_model.dart';
import 'package:echallan/model/warden_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  FirebaseAuth user = FirebaseAuth.instance;

  var userName = ''.obs;
  var usersList = <WardenModel>[].obs;
  var challanList = <ChallanModel>[].obs;
  var unpaidChallans = <ChallanModel>[].obs;
  var paidChallans = <ChallanModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserName();
    fetchUsersByRole('warden');
    fetchChallanData();
  }

  void fetchUserName() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          userName.value = userDoc['first_name'];
          print("First name is: " + userName.value);
        } else {
          print("User document does not exist.");
        }
      } else {
        print("No current user logged in.");
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  Future<void> fetchUsersByRole(String role) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: role)
          .get();

      List<WardenModel> users = querySnapshot.docs.map((doc) {
        return WardenModel.fromDocumentSnapshot(doc);
      }).toList();

      usersList.value = users;
      print("Fetched ${users.length} users with role $role");
    } catch (e) {
      print("Error fetching users by role: $e");
    }
  }

  Future<void> fetchChallanData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('challan').get();

      List<ChallanModel> challans =
          await Future.wait(querySnapshot.docs.map((doc) async {
        ChallanModel challan = ChallanModel.fromDocumentSnapshot(doc);
        await challan.fetchOfficerDetails();
        return challan;
      }).toList());

      unpaidChallans.value = challans
          .where((challan) => challan.paymentStatus == 'unpaid')
          .toList();
      paidChallans.value =
          challans.where((challan) => challan.paymentStatus == 'paid').toList();

      challanList.value = challans;
      print("Fetched ${challans.length} challans");
    } catch (e) {
      print("Error fetching challan data: $e");
    }
  }
}
