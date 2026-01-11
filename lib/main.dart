import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load saved settings
  final storageService = StorageService();
  final isDarkMode = await storageService.loadDarkMode();
  final sessions = await storageService.loadSessions();

  runApp(MyApp(
    initialDarkMode: isDarkMode,
    initialSessions: sessions,
  ));
}

class MyApp extends StatelessWidget {
  final bool initialDarkMode;
  final List<dynamic> initialSessions;

  const MyApp({
    super.key,
    required this.initialDarkMode,
    required this.initialSessions,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final appState = AppState();
        appState.setDarkMode(initialDarkMode);
        appState.setSessions(initialSessions.cast());
        return appState;
      },
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'AI Chat Hub',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
              ),
            ),
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
