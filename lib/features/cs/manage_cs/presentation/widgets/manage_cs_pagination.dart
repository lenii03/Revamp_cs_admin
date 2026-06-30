import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../bloc/manage_cs_bloc.dart';
import '../bloc/manage_cs_event.dart';

class ManageCsPaginationWidget extends StatefulWidget {
  const ManageCsPaginationWidget({super.key});

  @override
  State<ManageCsPaginationWidget> createState() =>
      _ManageCsPaginationWidgetState();
}

class _ManageCsPaginationWidgetState extends State<ManageCsPaginationWidget> {
  final List<int> _perPageOptions = [10, 20, 30, 50];

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageCsBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Show",
                style: TextStyle(
                  color: AppColors.secondaryTextColorDark,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.systemGroupedBackgroundDark,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.separatorDark),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: bloc.perPage,
                    dropdownColor: AppColors.systemGroupedBackgroundDark,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    items: _perPageOptions.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("$value"),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          bloc.perPage = newValue;
                          bloc.currentPage = 1;
                        });
                        bloc.add(FetchCsList());
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "1 - 16 of 16 entries",
                style: TextStyle(
                  color: AppColors.secondaryTextColorDark,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          Row(
            children: [
              _buildNavButton(
                icon: Icons.first_page_rounded,
                isEnabled: bloc.currentPage > 1,
                onTap: () {
                  setState(() => bloc.currentPage = 1);
                  bloc.add(FetchCsList());
                },
              ),
              const SizedBox(width: 4),
              // Tombol Previous (<)
              _buildNavButton(
                icon: Icons.keyboard_arrow_left_rounded,
                isEnabled: bloc.currentPage > 1,
                onTap: () {
                  setState(() => bloc.currentPage--);
                  bloc.add(FetchCsList());
                },
              ),
              const SizedBox(width: 8),
              // Nomor Halaman Aktif
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF06B6D4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${bloc.currentPage} of 1",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Tombol Next (>)
              _buildNavButton(
                icon: Icons.keyboard_arrow_right_rounded,
                isEnabled: false,
                onTap: () {
                  setState(() => bloc.currentPage++);
                  bloc.add(FetchCsList());
                },
              ),
              const SizedBox(width: 4),
              // Tombol Last Page (>|)
              _buildNavButton(
                icon: Icons.last_page_rounded,
                isEnabled: false,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEnabled
              ? AppColors.systemGroupedBackgroundDark
              : AppColors.systemBackgroundDark.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isEnabled ? AppColors.separatorDark : Colors.transparent,
          ),
        ),
        child: Icon(
          icon,
          color: isEnabled ? Colors.white : Colors.grey.withOpacity(0.5),
          size: 18,
        ),
      ),
    );
  }
}
