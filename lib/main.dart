import 'package:el_csadmin/core/theme/theme.dart';
import 'package:el_csadmin/core/theme/theme_cubit.dart';
import 'package:el_csadmin/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'injector.dart';

const bool _forceUpdateSplash = bool.fromEnvironment(
  'FORCE_UPDATE_SPLASH',
  defaultValue: false,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<AuthenticationBloc>()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'CS Admin',
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: themeMode,

            // Auto-update membandingkan binary Release. Pada mode Debug,
            // langsung buka login agar file debug tidak dianggap update.
            home: kReleaseMode || _forceUpdateSplash
                ? SplashScreen(
                    simulateUpdate: !kReleaseMode && _forceUpdateSplash,
                  )
                : const LoginPage(),
          );
        },
      ),
    );
  }
}
