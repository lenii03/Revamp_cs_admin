import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/online/approval/data/models/link_account_model.dart';
import 'package:el_csadmin/injector.dart';
import 'package:el_csadmin/shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import 'package:el_csadmin/shared/widgets/app_data_grid.dart';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../core/theme/src/app_colors.dart';

class ApprovalDetailDialog extends StatelessWidget {
  final ApprovalScreenModel data;

  const ApprovalDetailDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    int perms = int.tryParse(data.permissions) ?? 0;
    bool viewOnly = (perms & 1) != 0;
    bool syariah = (perms & 2) != 0;
    bool delayed = (perms & 4) != 0;
    bool vip = (perms & 8) != 0;
    bool research = (perms & 16) != 0;
    bool announcement = (perms & 32) != 0;

    return Dialog(
      backgroundColor: AppColors.systemGroupedBackgroundDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Approval',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.destructiveRedDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // DETAILS
              _buildInfoRow('Action', _buildActionText(data.action)),
              _buildInfoRow(
                'Login Id',
                Text(
                  data.loginId,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              _buildInfoRow(
                'Login Type',
                Text(
                  _getLoginTypeName(data.loginType),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              _buildInfoRow(
                'Sales / Branch Id',
                Text(
                  data.salesBranchId,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              _buildInfoRow(
                'Email',
                Text(
                  data.email,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              _buildInfoRow(
                'Handphone No',
                Text(
                  data.handphoneNo,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              _buildInfoRow(
                'Birth Date',
                Text(
                  data.birthDate,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              _buildInfoRow('Status', _buildStatusBadge(data.status)),

              // PERMISSIONS
              _buildInfoRow(
                'Permissions',
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildReadOnlyCheckbox('View Only', viewOnly),
                        ),
                        Expanded(
                          child: _buildReadOnlyCheckbox('Syariah', syariah),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: _buildReadOnlyCheckbox('Delayed', delayed),
                        ),
                        Expanded(child: _buildReadOnlyCheckbox('VIP', vip)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: _buildReadOnlyCheckbox('Research', research),
                        ),
                        Expanded(
                          child: _buildReadOnlyCheckbox(
                            'Announcement',
                            announcement,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              _buildInfoRow(
                'Expired',
                Text(
                  data.accountExpired == ""
                      ? "Never Expired"
                      : data.accountExpired,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),

              const SizedBox(height: 16),

              FutureBuilder<Map<String, dynamic>>(
                future: locator<ApiDatafeedNetworkDataSource>()
                    .fetchLinkedAccountsDetail(data.loginId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          color: AppColors.primaryDark,
                        ),
                      ),
                    );
                  }

                  final oldLinks =
                      (snapshot.data?['old'] as List<LinkAccountInfoModel>?) ??
                      [];
                  final newLinks =
                      (snapshot.data?['new']
                          as List<NewLinkAccountInfoModel>?) ??
                      [];

                  return Column(
                    children: [
                      // 1. Accordion Linked Account (Lama)
                      Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          backgroundColor: AppColors.systemBackgroundDark,
                          collapsedBackgroundColor:
                              AppColors.systemBackgroundDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          title: const Text(
                            'Linked Account',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          children: [
                            Container(
                              height:
                                  200, // Batasi tinggi area tabel agar popup tidak kepanjangan
                              padding: const EdgeInsets.all(8),
                              child: oldLinks.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Tidak ada Linked Account',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  : AppDataGrid(
                                      columns: [
                                        TrinaColumn(
                                          title: 'Account Id',
                                          field: 'accountId',
                                          type: TrinaColumnType.text(),
                                          width: 100,
                                        ),
                                        TrinaColumn(
                                          title: 'Name',
                                          field: 'name',
                                          type: TrinaColumnType.text(),
                                          width: 180,
                                        ),
                                        TrinaColumn(
                                          title: 'Created',
                                          field: 'created',
                                          type: TrinaColumnType.text(),
                                          width: 120,
                                        ),
                                        TrinaColumn(
                                          title: 'Created By',
                                          field: 'createdBy',
                                          type: TrinaColumnType.text(),
                                          width: 100,
                                        ),
                                      ],
                                      rows: oldLinks
                                          .map(
                                            (link) => TrinaRow(
                                              cells: {
                                                'accountId': TrinaCell(
                                                  value: link.accountId,
                                                ),
                                                'name': TrinaCell(
                                                  value: link.accountName,
                                                ),
                                                'created': TrinaCell(
                                                  value: link.createdDate,
                                                ),
                                                'createdBy': TrinaCell(
                                                  value: link.createdBy,
                                                ),
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 2. Accordion New Linked Account (Baru)
                      Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          backgroundColor: AppColors.systemBackgroundDark,
                          collapsedBackgroundColor:
                              AppColors.systemBackgroundDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          title: const Text(
                            'New Linked Account',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          children: [
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(8),
                              child: newLinks.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Tidak ada New Linked Account',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  : AppDataGrid(
                                      columns: [
                                        TrinaColumn(
                                          title: 'Action Type',
                                          field: 'action',
                                          type: TrinaColumnType.text(),
                                          width: 120,
                                          // Mewarnai teks khusus kolom Action Type
                                          renderer: (ctx) => Text(
                                            ctx.cell.value.toString(),
                                            style: const TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        TrinaColumn(
                                          title: 'Account Id',
                                          field: 'accountId',
                                          type: TrinaColumnType.text(),
                                          width: 100,
                                        ),
                                        TrinaColumn(
                                          title: 'Name',
                                          field: 'name',
                                          type: TrinaColumnType.text(),
                                          width: 180,
                                        ),
                                        TrinaColumn(
                                          title: 'Created',
                                          field: 'created',
                                          type: TrinaColumnType.text(),
                                          width: 120,
                                        ),
                                      ],
                                      rows: newLinks
                                          .map(
                                            (NewLinkAccountInfoModel link) =>
                                                TrinaRow(
                                                  cells: {
                                                    'action': TrinaCell(
                                                      value: link.actionType,
                                                    ),
                                                    'accountId': TrinaCell(
                                                      value: link.accountId,
                                                    ),
                                                    'name': TrinaCell(
                                                      value: link.accountName,
                                                    ),
                                                    'created': TrinaCell(
                                                      value: link.createdDate,
                                                    ),
                                                  },
                                                ),
                                          )
                                          .toList(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 32),

              // BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.separatorDark),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {}, // TODO: Action Approve
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {}, // TODO: Action Reject
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helpers internal
  Widget _buildInfoRow(String label, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildActionText(String action) {
    Color textColor = Colors.white;
    if (action.toLowerCase() == 'add')
      textColor = Colors.greenAccent;
    else if (action.toLowerCase() == 'delete')
      textColor = Colors.redAccent;
    else if (action.toLowerCase() == 'edit')
      textColor = Colors.orangeAccent;
    return Text(
      action,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor = Colors.grey.shade600;
    if (status.toLowerCase() == 'approved')
      bgColor = const Color(0xFF4CAF50);
    else if (status.toLowerCase() == 'rejected')
      bgColor = const Color(0xFFF44336);
    else if (status.toLowerCase() == 'pending')
      bgColor = const Color(0xFFC08080);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildReadOnlyCheckbox(String label, bool value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: IgnorePointer(
            child: Checkbox(
              value: value,
              onChanged: (_) {},
              activeColor: const Color(0xFF8B5CF6),
              side: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  String _getLoginTypeName(String typeStr) {
    int type = int.tryParse(typeStr) ?? -1;
    switch (type) {
      case 1:
        return 'Client';
      case 2:
        return 'Sales';
      case 3:
        return 'Branch';
      case 0:
        return 'Demo Account';
      default:
        return 'Tipe Lain ($type)';
    }
  }
}
