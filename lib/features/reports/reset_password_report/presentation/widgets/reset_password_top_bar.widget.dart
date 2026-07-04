// import 'package:flutter/material.dart';
// import '../../../../../core/theme/src/app_colors.dart';

// class ResetPasswordTopBarWidget extends StatefulWidget {
//   const ResetPasswordTopBarWidget({super.key});

//   @override
//   State<ResetPasswordTopBarWidget> createState() => _ResetPasswordTopBarWidgetState();
// }

// class _ResetPasswordTopBarWidgetState extends State<ResetPasswordTopBarWidget> {
//   final List<String> years = List.generate(20, (int index) => (DateTime.now().year - index).toString());
//   final List<String> months = ["Show All", "Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  
//   String selectedYear = DateTime.now().year.toString();
//   String selectedMonth = "Show All";

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _buildDropdown(years, selectedYear, (val) => setState(() => selectedYear = val!)),
//         const SizedBox(width: 16),
//         _buildDropdown(months, selectedMonth, (val) => setState(() => selectedMonth = val!)),
//         const SizedBox(width: 16),
//         Expanded(
//           flex: 4,
//           child: Container(
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.systemGroupedBackgroundDark,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: AppColors.separatorDark),
//             ),
//             child: const TextField(
//               style: TextStyle(color: Colors.white, fontSize: 13),
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 hintStyle: TextStyle(color: AppColors.secondaryTextColorDark),
//                 prefixIcon: Icon(Icons.search, color: AppColors.textColorDark, size: 18),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//           ),
//         ),
//         const Spacer(flex: 2),

//         IconButton(
//           onPressed: () {
//             // TODO: Fungsi PDF Preview
//           },
//           icon: const Icon(Icons.print, color: AppColors.textColorDark),
//           tooltip: 'Print Report',
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdown(List<String> items, String currentValue, ValueChanged<String?> onChanged) {
//     return Container(
//       height: 40,
//       width: 120,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: AppColors.systemGroupedBackgroundDark,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppColors.separatorDark),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: currentValue,
//           isExpanded: true,
//           dropdownColor: AppColors.systemGroupedBackgroundDark,
//           icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
//           style: const TextStyle(color: Colors.white, fontSize: 13),
//           onChanged: onChanged,
//           items: items.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
//         ),
//       ),
//     );
//   }
// }