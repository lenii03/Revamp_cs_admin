import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';

class OnlineIdTopBarWidget extends StatelessWidget {
  const OnlineIdTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.systemGroupedBackgroundDark,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.separatorDark),
            ),
            child: const TextField(
              style: TextStyle(color: AppColors.textColorDark, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search Login ID / Email...',
                hintStyle: TextStyle(color: AppColors.secondaryTextColorDark),
                suffixIcon: Icon(Icons.search, color: AppColors.textColorDark, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
        ),
        const Spacer(flex: 5),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.print, color: AppColors.textColorDark),
          tooltip: 'Print Data',
        ),
      ],
    );
  }
}