import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'provider/weather_api_client.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherApiClient(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wheather App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.grey,
          ),
          textTheme: TextTheme(
            titleLarge: GoogleFonts.quicksand(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            titleSmall: GoogleFonts.quicksand(
              fontSize: 16,
            ),
            bodyMedium: GoogleFonts.quicksand(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            bodySmall: GoogleFonts.quicksand(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
