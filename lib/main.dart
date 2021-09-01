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
        theme: ThemeData(
          buttonColor: Colors.blue[700],
          textTheme: TextTheme(
            headline1: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                  fontSize: 30, color: Colors.amber, fontWeight: FontWeight.w600),
            ),
            headline2: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                  fontSize: 20, color: Colors.amber, fontWeight: FontWeight.w600),
            ),
            headline3: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                  fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            bodyText1: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                  fontSize: 15, color: Colors.amber, fontWeight: FontWeight.w600),
            ),
            button: GoogleFonts.aBeeZee(
              textStyle: TextStyle(color: Colors.amber),
            ),
          ),
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
