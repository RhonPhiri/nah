import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/data_export.dart';
import 'ui/ui_export.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///variable to hold the NahDb instance
final nahDb = NahDb();
Future<void> main() async {
  //initialize
  WidgetsFlutterBinding.ensureInitialized();

  //Limiting the orientation of the mobile to upright or downward orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Method to initialize the database before the app starts
  await initializeApp(nahDb);

  ///Variable to hold the sharedPrefs instance
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(prefs)),
        ChangeNotifierProvider(
          create:
              (context) => HymnalProvider(
                HymnRepository(HymnService(), nahDb),
                HymnalRepository(HymnalService(), nahDb),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => HymnProvider(HymnRepository(HymnService(), nahDb)),
        ),
        ChangeNotifierProvider(
          create:
              (context) => HymnCollectionProvider(HymnCollectionRepo(nahDb)),
        ),
        ChangeNotifierProvider(
          create:
              (context) => BookmarkedHymnsProvider(
                HymnRepository(HymnService(), nahDb),
                BookmarkRepository(nahDb),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );

  ///close database and release resources
  // await closeDatabaseOnAppExit(nahDb);
}

///Method to initalize the app & database
Future<void> initializeApp(NahDb nahDb) async {
  try {
    await nahDb.database;
  } catch (e) {
    debugPrint('Error initializing the database: $e');
  }
}

// ///method to release database resources upon closing the app
// Future<void> closeDatabaseOnAppExit(NahDb nahDb) async {
//   await nahDb.close();
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
