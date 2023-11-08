import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gastos/widgets/gastos.dart';

var kEsquemaDeCor = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 24, 24, 24),
);

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),

      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.black,
          background: Color.fromARGB(255, 98, 98, 98),
          onBackground: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme().copyWith(
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeData.dark().colorScheme.background,
          ),
        ),
      ),

      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kEsquemaDeCor,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kEsquemaDeCor.onPrimaryContainer,
            foregroundColor: kEsquemaDeCor.primaryContainer,
            centerTitle: true),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kEsquemaDeCor.onPrimaryContainer,
            foregroundColor: kEsquemaDeCor.primaryContainer,
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kEsquemaDeCor.secondaryContainer,
        ),
      ),
      //themeMode: ThemeMode.dark,
      home: const Gastos(),
    ),
  );
}
