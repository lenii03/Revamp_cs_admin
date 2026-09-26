import 'package:el_csadmin/core/theme/theme.dart';
import 'package:el_csadmin/core/theme/theme_cubit.dart';
import 'package:el_csadmin/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';
import 'core/navigation/app_navigator.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'injector.dart';
import 'shared/widgets/app_window_resize_frame.dart';

const bool _forceUpdateSplash = bool.fromEnvironment(
  'FORCE_UPDATE_SPLASH',
  defaultValue: false,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 460),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.show();
    await windowManager.focus();
  });
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
            navigatorKey: AppNavigator.navigatorKey,
            title: 'CS Admin',
            debugShowCheckedModeBanner: false,
            builder: (context, child) => AppWindowResizeFrame(
              child: child ?? const SizedBox.shrink(),
            ),
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: themeMode,
            home: const SplashScreen(simulateUpdate: _forceUpdateSplash),
          );
        },
      ),
    );
  }
}
