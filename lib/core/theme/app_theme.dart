import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  static const Color corPrimaria = Color(0xFF1B5E20); // verde escuro
  static const Color corSecundaria = Color(0xFF0D47A1); // azul escuro
  static const Color corFundoClaro = Color(0xFFF7F7F5);
  static const Color corTextoClaro = Color(0xFF1A1A1A);

  static const double alturaMinimaBotao = 64;
  static const double raioBorda = 16;

  static ThemeData temaPadrao() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: corPrimaria,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: corFundoClaro,
      textTheme: GoogleFonts.nunitoTextTheme().apply(
        bodyColor: corTextoClaro,
        displayColor: corTextoClaro,
      ),
    );

    return base.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, alturaMinimaBotao),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raioBorda),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: corPrimaria,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(raioBorda),
        ),
      ),
    );
  }

  /// Tema de alto contraste: fundo preto, texto branco/amarelo,
  /// para usuários com baixa visão.
  static ThemeData temaAltoContraste() {
    const corFundo = Colors.black;
    const corTexto = Colors.white;
    const corDestaque = Color(0xFFFFD600); // amarelo

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: corFundo,
      colorScheme: const ColorScheme.dark(
        primary: corDestaque,
        secondary: corDestaque,
        surface: Color(0xFF121212),
      ),
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: corTexto,
        displayColor: corTexto,
      ),
    );

    return base.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: corDestaque,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, alturaMinimaBotao),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raioBorda),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: corDestaque,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: corDestaque,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(raioBorda),
          side: const BorderSide(color: corDestaque, width: 1.5),
        ),
      ),
    );
  }
}
