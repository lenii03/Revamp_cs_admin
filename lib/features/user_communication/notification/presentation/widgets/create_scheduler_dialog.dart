import 'package:flutter/material.dart';

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
                Text(
                  "Create Scheduler",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
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
                Text(
                  "Never Expired",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
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
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
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
