import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChallanCard extends StatelessWidget {
  final String title;
  final int count;
  final String officerId;
  final String date;

  const ChallanCard({
    super.key,
    required this.title,
    required this.count,
    required this.officerId,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Icon and Challan Number Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF), // Soft Blue
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "NO #$count",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D4ED8), // Blue 700
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/pencil.png",
                  height: 8.h,
                  width: 16.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Right Column: Details list
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Receipt Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16, color: Color(0xFFE2E8F0)),
                  _buildDetailRow("Officer Name:", title),
                  const SizedBox(height: 4),
                  _buildDetailRow("Officer ID:", officerId),
                  const SizedBox(height: 4),
                  _buildDetailRow("Division:", "Hazara"),
                  const SizedBox(height: 4),
                  _buildDetailRow("Location:", "Abbottabad"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B), // Slate 500
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155), // Slate 700
          ),
        ),
      ],
    );
  }
}
