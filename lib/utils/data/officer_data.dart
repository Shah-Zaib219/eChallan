import 'package:echallan/controller/admin_controller.dart';
import 'package:echallan/model/warden_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficerData extends StatelessWidget {
  OfficerData({super.key});

  final adminController = Get.find<AdminController>();

  void _showWardenDetailsDialog(BuildContext context, WardenModel user) {
    // Filter challans for this specific warden
    final wardenChallans = adminController.challanList.where((c) => c.officerId == user.id).toList();
    final totalChallans = wardenChallans.length;
    final paidChallans = wardenChallans.where((c) => c.paymentStatus == 'paid').length;
    final unpaidChallans = wardenChallans.where((c) => c.paymentStatus == 'unpaid').length;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF6FF), // Soft Blue Tint
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFF1467A7), // Dark Blue Theme
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A), // Slate 900
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Warden ID: ${user.id}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B), // Slate 500
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 12),
              const Text(
                "Challan Statistics",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155), // Slate 700
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 12),
              _buildStatRow(
                icon: Icons.assignment_rounded,
                label: "Total Challans",
                value: "$totalChallans",
                color: const Color(0xFF6366F1), // Indigo
              ),
              const SizedBox(height: 8),
              _buildStatRow(
                icon: Icons.check_circle_rounded,
                label: "Paid Challans",
                value: "$paidChallans",
                color: const Color(0xFF10B981), // Emerald Green
              ),
              const SizedBox(height: 8),
              _buildStatRow(
                icon: Icons.warning_rounded,
                label: "Unpaid Challans",
                value: "$unpaidChallans",
                color: const Color(0xFFEF4444), // Rose Red
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1467A7), // Constants.buttonColor equivalent
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (adminController.usersList.isEmpty) {
          return const Center(
            child: Text(
              "No Wardens Found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
              ),
            ),
          );
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: adminController.usersList.length,
          itemBuilder: (context, index) {
            var user = adminController.usersList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC), // Slate 50
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1), // Slate 200 border
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showWardenDetailsDialog(context, user),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDBEAFE), // Blue 100
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Color(0xFF2563EB), // Blue 600
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.firstName} ${user.lastName}'.trim(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A), // Slate 900
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ID: ${user.id}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF64748B), // Slate 500
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: Color(0xFF94A3B8), // Slate 400
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
