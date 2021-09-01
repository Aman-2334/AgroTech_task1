import 'package:cultino/Screens/Screen1.dart';
import 'package:cultino/provider/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Screens/Screen2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(
        create: (_) => DataProvider(),
      ),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
            centerTitle: true,
            titleTextStyle: GoogleFonts.aBeeZee(
              textStyle: TextStyle(color: Colors.white),
            ),
            elevation: 0.0,
          ),
        ),
        home: Screen1(),
        routes: {
          Screen2.routeName: (ctx) => Screen2(),
        },
      ),
    );
  }
}
