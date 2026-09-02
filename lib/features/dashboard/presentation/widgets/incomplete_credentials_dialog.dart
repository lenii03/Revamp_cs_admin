import 'package:flutter/material.dart';

import '../../../../core/theme/src/app_colors.dart';
import '../../../../core/theme/theme.dart';
import '../../../../injector.dart';
import '../../../online/online_id/data/repositories/online_id_repository.dart';
import '../../../online/online_id/presentation/widgets/add_edit_online_id_dialog.dart';
import '../../data/models/incomplete_credential_item.dart';

class IncompleteCredentialsDialog extends StatefulWidget {
  const IncompleteCredentialsDialog({
    super.key,
    required this.users,
    required this.onUpdated,
  });

  final List<IncompleteCredentialItem> users;
  final VoidCallback onUpdated;

  @override
  State<IncompleteCredentialsDialog> createState() =>
      _IncompleteCredentialsDialogState();
}

class _IncompleteCredentialsDialogState
    extends State<IncompleteCredentialsDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String? _savingLoginId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<IncompleteCredentialItem> get _filteredUsers {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return widget.users;
    return widget.users.where((user) {
      return user.loginId.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query) ||
          user.phoneNumber.toLowerCase().contains(query) ||
          user.missingFields.any(
            (field) => field.toLowerCase().contains(query),
          );
    }).toList();
  }

  void _openEditDialog(IncompleteCredentialItem user) {
    showDialog<void>(
      context: context,
      builder: (_) => AddEditOnlineIdDialog(
        isEdit: true,
        initialData: {
          'loginId': user.loginId,
          'email': user.email == '-' ? '' : user.email,
          'loginType': user.loginType,
          'handphoneNo': user.phoneNumber == '-' ? '' : user.phoneNumber,
          'birthDate': user.birthDate == '-' ? '' : user.birthDate,
          'accountExpired': user.accountExpired == '-'
              ? ''
              : user.accountExpired,
          'permissions': user.permissions,
          'status': user.status,
          'salesId': user.salesId == '-' ? '' : user.salesId,
        },
        onSave: (payload) => _saveUser(user, payload),
      ),
    );
  }

  Future<void> _saveUser(
    IncompleteCredentialItem user,
    Map<String, dynamic> payload,
  ) async {
    if (_savingLoginId != null) return;
    setState(() => _savingLoginId = user.loginId);

    final result = await locator<OnlineIdRepository>().addOnlineUser1(payload);
    if (!mounted) return;

    result.fold(
      (error) {
        setState(() => _savingLoginId = null);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Failed to update ${user.loginId}: $error'),
              backgroundColor: AppColors.destructiveRedDark,
            ),
          );
      },
      (_) {
        final messenger = ScaffoldMessenger.of(context);
        widget.onUpdated();
        Navigator.of(context).pop();
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'The update request for ${user.loginId} was submitted successfully.',
              ),
              backgroundColor: AppColors.successGreen,
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final secondaryColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;
    final users = _filteredUsers;

    return Dialog(
      backgroundColor: containerColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 680,
          maxWidth: 880,
          maxHeight: 620,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 18),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD81B60).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.contact_page_outlined,
                      color: Color(0xFFFF80AB),
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Incomplete Credentials',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${widget.users.length} users require credential updates',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Close',
                    icon: Icon(Icons.close, color: secondaryColor),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: separatorColor),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: 'Search Login ID, email, phone, or missing field',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                          icon: const Icon(Icons.close, size: 18),
                        ),
                  isDense: true,
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(color: separatorColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(color: separatorColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: users.isEmpty
                  ? Center(
                      child: Text(
                        'No matching users found.',
                        style: TextStyle(color: secondaryColor),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: users.length,
                      separatorBuilder: (_, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return _CredentialUserRow(
                          user: users[index],
                          separatorColor: separatorColor,
                          secondaryColor: secondaryColor,
                          saving: _savingLoginId == users[index].loginId,
                          onEdit: _savingLoginId == null
                              ? () => _openEditDialog(users[index])
                              : null,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CredentialUserRow extends StatelessWidget {
  const _CredentialUserRow({
    required this.user,
    required this.separatorColor,
    required this.secondaryColor,
    required this.saving,
    required this.onEdit,
  });

  final IncompleteCredentialItem user;
  final Color separatorColor;
  final Color? secondaryColor;
  final bool saving;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: separatorColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFD81B60).withValues(alpha: 0.15),
            child: Text(
              user.loginId.isEmpty ? '?' : user.loginId[0].toUpperCase(),
              style: const TextStyle(
                color: Color(0xFFFF80AB),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 120,
            child: Text(
              user.loginId,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: user.missingFields
                  .map(
                    (field) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF647C).withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$field missing',
                        style: const TextStyle(
                          color: Color(0xFFFF8A9B),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(width: 12),
          Tooltip(
            message:
                'Email: ${user.email}\nPhone: ${user.phoneNumber}\nBirth Date: ${user.birthDate}',
            child: Icon(Icons.info_outline, size: 18, color: secondaryColor),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 74,
            child: OutlinedButton(
              onPressed: onEdit,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                side: const BorderSide(color: AppColors.primaryColor),
                foregroundColor: AppColors.primaryDark,
              ),
              child: saving
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
