import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/data_export.dart';
import 'ui/ui_export.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///variable to hold the DatabaseHelper instance
final dbHelper = DatabaseHelper();
Future<void> main() async {
  //initialize
  WidgetsFlutterBinding.ensureInitialized();

  //Limiting the orientation of the mobile to upright or downward orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Method to initialize the database before the app starts
  await initializeApp(dbHelper);

  ///Variable to hold the sharedPrefs instance
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(prefs)),
        ChangeNotifierProvider(
          create:
              (context) => HymnalProvider(
                HymnRepository(HymnService(), dbHelper),
                HymnalRepository(HymnalService(), dbHelper),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  HymnProvider(HymnRepository(HymnService(), dbHelper)),
        ),
        ChangeNotifierProvider(
          create:
              (context) => HymnCollectionProvider(HymnCollectionRepo(dbHelper)),
        ),
        ChangeNotifierProvider(
          create:
              (context) => BookmarkedHymnsProvider(
                HymnRepository(HymnService(), dbHelper),
                BookmarkRepository(dbHelper),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );

  ///close database and release resources
  // await closeDatabaseOnAppExit(dbHelper);
}

///Method to initalize the app & database
Future<void> initializeApp(DatabaseHelper dbHelper) async {
  try {
    await dbHelper.database;
  } catch (e) {
    debugPrint('Error initializing the database: $e');
  }
}

// ///method to release database resources upon closing the app
// Future<void> closeDatabaseOnAppExit(DatabaseHelper dbHelper) async {
//   await dbHelper.close();
//   debugPrint('database closed successfully!!!');
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final thememode = context.watch<ThemeProvider>().themeMode;
    return MaterialApp(
      theme: NahTheme.light(),
      darkTheme: NahTheme.dark(),
      themeMode: thememode,
      home: HymnScreen(),
    );
  }
}
