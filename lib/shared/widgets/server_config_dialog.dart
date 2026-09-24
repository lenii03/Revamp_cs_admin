import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/network/server_config.dart';
import '../../core/theme/src/app_colors.dart';
import '../../data/remote/dio_client.dart';
import '../../injector.dart';
import 'custom_text_field.dart';

class ServerConfigDialog extends StatefulWidget {
  final bool isDismissible;

  const ServerConfigDialog({super.key, this.isDismissible = true});

  static Future<bool?> show(BuildContext context, {bool isDismissible = true}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => ServerConfigDialog(isDismissible: isDismissible),
    );
  }

  @override
  State<ServerConfigDialog> createState() => _ServerConfigDialogState();
}

class _ServerConfigDialogState extends State<ServerConfigDialog> {
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  bool _isTesting = false;
  bool _isSaving = false;
  String? _statusMessage;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _loadInitialConfig();
  }

  Future<void> _loadInitialConfig() async {
    final host = await ServerConfig.getHost();
    final port = await ServerConfig.getPort();
    if (mounted) {
      setState(() {
        _hostController.text = host;
        _portController.text = port;
      });
    }
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    final host = _hostController.text.trim();
    final port = _portController.text.trim();

    if (host.isEmpty) {
      setState(() {
        _statusMessage = "Host / IP Address tidak boleh kosong.";
        _isSuccess = false;
      });
      return;
    }

    setState(() {
      _isTesting = true;
      _statusMessage = null;
    });

    final ok = await ServerConfig.checkConnection(host: host, port: port);

    if (!mounted) return;
    setState(() {
      _isTesting = false;
      _isSuccess = ok;
      _statusMessage = ok
          ? "Koneksi berhasil terhubung ke server!"
          : "Gagal terhubung ke server. Periksa IP/Port.";
    });
  }

  Future<void> _saveConfig() async {
    final host = _hostController.text.trim();
    final port = _portController.text.trim();

    if (host.isEmpty) {
      setState(() {
        _statusMessage = "Host / IP Address tidak boleh kosong.";
        _isSuccess = false;
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _statusMessage = null;
    });

    final ok = await ServerConfig.checkConnection(host: host, port: port);

    if (!mounted) return;

    if (!ok) {
      setState(() {
        _isSaving = false;
        _isSuccess = false;
        _statusMessage =
            "Gagal terhubung ke server. Pastikan server aktif atau periksa IP/Port.";
      });
      return;
    }

    await ServerConfig.saveServer(host, port);
    final newBaseUrl = await ServerConfig.getBaseUrl();
    if (newBaseUrl.isNotEmpty) {
      locator<DioClient>().setBaseUrl(newBaseUrl);
    }

    if (!mounted) return;
    setState(() {
      _isSaving = false;
    });
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F1A24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
      child: Container(
        width: 380,
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Konfigurasi Server IP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Host / IP Address",
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "Contoh: 115.85.84.52 atau localhost",
              controller: _hostController,
              prefixIcon: Icons.dns_outlined,
              maxLength: 253,
            ),
            const SizedBox(height: 16),
            const Text(
              "Port",
              style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "Contoh: 9001 atau 8080",
              controller: _portController,
              prefixIcon: Icons.tag,
              maxLength: 5,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            if (_statusMessage != null) ...[
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _isSuccess
                        ? Icons.check_circle_outline
                        : Icons.error_outline_rounded,
                    color: _isSuccess
                        ? AppColors.successGreen
                        : AppColors.errorRed,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _statusMessage!,
                      style: TextStyle(
                        color: _isSuccess
                            ? AppColors.successGreen
                            : AppColors.errorRed,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                TextButton.icon(
                  onPressed: (_isTesting || _isSaving) ? null : _testConnection,
                  icon: _isTesting
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Icon(Icons.wifi_find_rounded, size: 16),
                  label: const Text("Tes", style: TextStyle(fontSize: 13)),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                  ),
                ),
                const Spacer(),
                if (widget.isDismissible)
                  TextButton(
                    onPressed: (_isTesting || _isSaving)
                        ? null
                        : () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textGrey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Batal"),
                  ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: (_isTesting || _isSaving) ? null : _saveConfig,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: const Color(0xFF07111A),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF07111A),
                          ),
                        )
                      : const Text(
                          "Simpan",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
