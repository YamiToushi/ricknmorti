import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ricknmorti/models/character.dart';
import 'package:ricknmorti/utilities/colors/custom_colors.dart';
import 'package:ricknmorti/widget/bottomnavbar/custom_bottom_bar.dart';
import 'providers/character_provider.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  await Hive.openBox<Character>('characters');
  await Hive.openBox<Character>('favorites');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CharacterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RicknMorty App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.lightColors.primary,
          secondary: AppColors.lightColors.secondary,
          surface: AppColors.lightColors.background,
          onPrimary: AppColors.lightColors.text,
          onSecondary: AppColors.lightColors.text,
          onSurface: AppColors.lightColors.text,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: AppColors.darkColors.primary,
          secondary: AppColors.darkColors.secondary,
          surface: AppColors.darkColors.background,
          onPrimary: AppColors.darkColors.text,
          onSecondary: AppColors.darkColors.text,
          onSurface: AppColors.darkColors.text,
        ),
      ),
      themeMode: themeProvider.themeMode,
      home: const BottomNavBar(),
    );
  }
}
