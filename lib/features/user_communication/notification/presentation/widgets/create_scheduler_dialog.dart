import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';

class CreateSchedulerDialog extends StatefulWidget {
  const CreateSchedulerDialog({super.key});

  @override
  State<CreateSchedulerDialog> createState() => _CreateSchedulerDialogState();
}

class _CreateSchedulerDialogState extends State<CreateSchedulerDialog> {
  bool isNeverExpired = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.systemGroupedBackgroundDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Create Scheduler",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildField("Title", "Insert Title"),
            _buildField("Sub Title", "Insert Sub Title"),
            _buildField("Execute Time", "Insert Execute Time"),
            _buildField("Expiry", "Insert Expiry"),
            Row(
              children: [
                Checkbox(
                  value: isNeverExpired,
                  onChanged: (val) => setState(() => isNeverExpired = val!),
                ),
                const Text(
                  "Never Expired",
                  style: TextStyle(color: AppColors.textColorDark),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  /* TODO: Panggil BLoC CreateScheduler */
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textColorDark),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
