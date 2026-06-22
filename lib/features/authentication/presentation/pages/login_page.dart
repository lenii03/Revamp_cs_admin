import 'package:el_csadmin/core/network/server_config.dart';
import 'package:el_csadmin/core/theme/src/app_colors.dart';
import 'package:el_csadmin/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:el_csadmin/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:el_csadmin/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:el_csadmin/shared/widgets/custom_button.dart';
import 'package:el_csadmin/shared/widgets/custom_text_field.dart';
import 'package:el_csadmin/shared/widgets/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedConfig();
  }

  Future<void> _loadSavedConfig() async {
    final host = await ServerConfig.getHost();
    final port = await ServerConfig.getPort();
    setState(() {
      _hostController.text = host;
      _portController.text = port;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }

  void _showIpConfigDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          "Konfigurasi Server IP",
          style: TextStyle(color: AppColors.textWhite),
        ),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Host / IP Address",
                style: TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: "Contoh: 192.168.1.100",
                controller: _hostController,
                prefixIcon: Icons.dns_outlined,
              ),
              const SizedBox(height: 16),
              const Text(
                "Port",
                style: TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: "Contoh: 8080",
                controller: _portController,
                prefixIcon: Icons.numbers_outlined,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Batal",
              style: TextStyle(color: AppColors.textGrey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () async {
              await ServerConfig.saveServer(
                _hostController.text.trim(),
                _portController.text.trim(),
              );

              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.successGreen,
                    content: Text("Konfigurasi Server berhasil disimpan!"),
                  ),
                );
              }
            },
            child: const Text(
              "Simpan",
              style: TextStyle(
                color: AppColors.backgroundDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(48.0),
              decoration: const BoxDecoration(color: AppColors.backgroundDark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Badge kecil
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "CS Admin System",
                      style: TextStyle(
                        color: AppColors.accentGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Manage with Precision.\nKuasai Kendali Sistem.",
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Platform manajemen CS terpadu yang dirancang untuk kecepatan, akurasi, dan kemudahan operasional.",
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.cardDark,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.textGrey.withOpacity(0.2),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.analytics_outlined,
                        color: AppColors.textGrey,
                        size: 64,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 1, // Mengambil 50% layar
            child: Container(
              color: AppColors.cardDark,
              padding: const EdgeInsets.all(48.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textWhite,
                        side: BorderSide(
                          color: AppColors.textGrey.withOpacity(0.5),
                        ),
                      ),
                      onPressed: _showIpConfigDialog,
                      icon: const Icon(Icons.settings_ethernet, size: 18),
                      label: const Text("Konfigurasi IP"),
                    ),
                  ),

                  const Spacer(),
                  SizedBox(
                    width: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Masuk ke Akun Anda",
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Silakan masukkan detail login Anda di bawah ini.",
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),

                        const Text(
                          "ID PENGGUNA",
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: "Contoh: admin_leni",
                          controller: _usernameController,
                          prefixIcon: Icons.person_outline,
                        ),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "KATA SANDI",
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Lupa Kata Sandi?",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          hintText: "••••••••",
                          controller: _passwordController,
                          isPassword: true,
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 16),

                        // Checkbox Ingat Saya
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _rememberMe,
                                activeColor: AppColors.primaryColor,
                                checkColor: AppColors.backgroundDark,
                                side: const BorderSide(
                                  color: AppColors.textGrey,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Ingat saya di perangkat ini",
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        BlocConsumer<AuthenticationBloc, AuthenticationState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.errorRed,
                                  content: Text(
                                    state.message,
                                    style: const TextStyle(
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is AuthSuccess) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainLayout(),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                              text: "Masuk Sekarang",
                              isLoading: state is AuthLoading,
                              onPressed: () {
                                if (_usernameController.text.isEmpty ||
                                    _passwordController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: AppColors.errorRed,
                                      content: Text(
                                        "ID Pengguna dan Kata Sandi tidak boleh kosong",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                context.read<AuthenticationBloc>().add(
                                  LoginSubmitted(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "© 2026 CS Admin System. Seluruh hak cipta dilindungi.",
                    style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
