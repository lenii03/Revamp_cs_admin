import 'package:el_csadmin/data/remote/dio_client.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/server_config.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/layout/main_layout.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';
import '../bloc/authentication_state.dart';

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
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _resetPasswordController =
      TextEditingController();

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
    final savedBaseUrl = await ServerConfig.getBaseUrl();
    if (savedBaseUrl.isNotEmpty) {
      locator<DioClient>().dio.options.baseUrl = savedBaseUrl;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _hostController.dispose();
    _portController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    _resetPasswordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (context.read<AuthenticationBloc>().state is AuthLoading) return;

    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.errorRed,
          content: Text('Username and password are required.'),
        ),
      );
      return;
    }

    context.read<AuthenticationBloc>().add(
      LoginSubmitted(username: username, password: password),
    );
  }

  Future<void> _showForgotPasswordDialog() async {
    _resetPasswordController.text = _usernameController.text.trim();

    final formKey = GlobalKey<FormState>();
    final authBloc = context.read<AuthenticationBloc>();

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: authBloc,
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.errorRed,
                  content: Text(
                    'Password reset failed: ${state.errorMessage}',
                  ),
                ),
              );
            } else if (state is ForgotPasswordSuccess) {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.successGreen,
                  content: Text(
                    state.message.isEmpty
                        ? 'Password reset request completed successfully.'
                        : state.message,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final isSubmitting = state is ForgotPasswordLoading;

            return Dialog(
              backgroundColor: AppColors.cardDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: AppColors.textGrey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Container(
                width: 420,
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan Icon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock_reset_rounded,
                              color: AppColors.primaryColor,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Deskripsi
                      const Text(
                        'Enter your username. A new password will be sent to the email address registered to your account.',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Label Form
                      const Text(
                        "USERNAME",
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Input Field
                      TextFormField(
                        controller: _resetPasswordController,
                        maxLength: 32,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9._]'),
                          ),
                        ],
                        autofocus: true,
                        enabled: !isSubmitting,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: "username",
                          hintStyle: TextStyle(
                            color: AppColors.textGrey.withValues(alpha: 0.5),
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: AppColors.textGrey,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: AppColors.backgroundDark,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Username is required'
                            : null,
                        onFieldSubmitted: (_) => _resetPassword(
                          context,
                          formKey,
                          _resetPasswordController,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Aksi / Tombol
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: isSubmitting
                                ? null
                                : () => Navigator.pop(dialogContext),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: isSubmitting
                                ? null
                                : () => _resetPassword(
                                    context,
                                    formKey,
                                    _resetPasswordController,
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isSubmitting
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppColors.backgroundDark,
                                    ),
                                  )
                                : const Text(
                                    'Send Request',
                                    style: TextStyle(
                                      color: AppColors.backgroundDark,
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
          },
        ),
      ),
    );
  }

  void _resetPassword(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController controller,
  ) {
    if (formKey.currentState?.validate() != true) return;

    context.read<AuthenticationBloc>().add(
      ForgotPasswordSubmitted(loginId: controller.text.trim()),
    );
  }

  void _showIpConfigDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: const Text(
          "Server Configuration",
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
                hintText: "Example: 192.168.1.100",
                controller: _hostController,
                prefixIcon: Icons.dns_outlined,
                maxLength: 253,
              ),
              const SizedBox(height: 16),
              const Text(
                "Port",
                style: TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: "Example: 8080",
                controller: _portController,
                prefixIcon: Icons.numbers_outlined,
                maxLength: 5,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.textGrey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () async {
              final hostInput = _hostController.text.trim();
              final portInput = _portController.text.trim();
              await ServerConfig.saveServer(hostInput, portInput);
              final newBaseUrl = await ServerConfig.getBaseUrl();
              locator<DioClient>().dio.options.baseUrl = newBaseUrl;

              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.successGreen,
                    content: Text("Server configuration saved successfully."),
                  ),
                );
              }
            },
            child: const Text(
              "Save",
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 800;
          return Row(
            children: [
              if (!compact)
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(48.0),
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundDark,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen.withValues(alpha: 0.2),
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
                          "Manage with Precision.\nStay in Control.",
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "A unified CS management platform designed for speed, accuracy, and operational efficiency.",
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 48),

                        Expanded(
                          child: Center(
                            child: Image.asset(
                              'assets/images/logo_csadmin.png',
                              width: 700,
                              height: 700,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // --------------------------------------------------------
                      ],
                    ),
                  ),
                ),

              Expanded(
                flex: 1,
                child: Container(
                  color: AppColors.cardDark,
                  padding: EdgeInsets.all(compact ? 24 : 48),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textWhite,
                            side: BorderSide(
                              color: AppColors.textGrey.withValues(alpha: 0.5),
                            ),
                          ),
                          onPressed: _showIpConfigDialog,
                          icon: const Icon(Icons.settings_ethernet, size: 18),
                          label: const Text("Server Settings"),
                        ),
                      ),

                      const Spacer(),
                      SizedBox(
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Login Screen",
                              style: TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Enter your credentials to continue.",
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 32),

                            const Text(
                              "USERNAME",
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              hintText: "Username",
                              controller: _usernameController,
                              prefixIcon: Icons.person_outline,
                              focusNode: _usernameFocus,
                              autofocus: true,
                              maxLength: 32,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9._]'),
                                ),
                              ],
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) => _passwordFocus.requestFocus(),
                            ),
                            const SizedBox(height: 24),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "PASSWORD",
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            CustomTextField(
                              hintText: "••••••••",
                              controller: _passwordController,
                              isPassword: true,
                              prefixIcon: Icons.lock_outline,
                              focusNode: _passwordFocus,
                              maxLength: 64,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _submitLogin(),
                            ),
                            const SizedBox(height: 16),

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
                                  "Remember me",
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: _showForgotPasswordDialog,
                                  child: const Text(
                                    "Forgot Password? Reset here.",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            BlocConsumer<
                              AuthenticationBloc,
                              AuthenticationState
                            >(
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
                                  text: "Login",
                                  isLoading: state is AuthLoading,
                                  onPressed: _submitLogin,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "© 2026 CS Admin System. Seluruh hak cipta dilindungi.",
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
