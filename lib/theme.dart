import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme(brightness, BuildContext context) {
  var baseTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.nunito().fontFamily,
    //default text theme with nunito and goldman
    textTheme: GoogleFonts.nunitoTextTheme(
      Theme.of(context).textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.goldman(
        fontSize: 48,
        letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.goldman(
        fontSize: 40,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.goldman(
        fontSize: 32,
      ),
      headlineLarge: GoogleFonts.goldman(
        fontSize: 28,
        letterSpacing: 0.25,
      ),
      headlineMedium: GoogleFonts.goldman(
        fontSize: 24,
        letterSpacing: 0.25,
      ),
      headlineSmall: GoogleFonts.goldman(
        fontSize: 20,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 20,
        letterSpacing: 0.15,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.9,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.25,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),

    //bordered textfields extended from existing theme
    inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(1),
            ),
          ),
        ),

    // remove the tinting
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        surfaceTintColor: MaterialStateProperty.all<Color>(Colors.transparent),
      ),
    ),
  );

  ThemeData theme;

  if (brightness == Brightness.light) {
    theme = baseTheme.copyWith(
        colorScheme: m3SysLightScheme,
        scaffoldBackgroundColor: m3SysLightScheme.background);
  } else {
    theme = baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark, seedColor: Colors.red),
    );
  }

  return theme;
}

//exported colors from figma and generated using gpt
ColorScheme m3SysLightScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFF8201),
  onPrimary: Color(0xFFF8F2EC),
  primaryContainer: Color(0xFF2E2E41),
  onPrimaryContainer: Color(0xFFF8F2EC),
  secondary: Color(0xFF49499A),
  onSecondary: Color(0xFF2E2E41),
  secondaryContainer: Color(0xFF48486A),
  onSecondaryContainer: Color(0xFFF8F2EC),
  tertiary: Color(0xFFFA00FF),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD400),
  onTertiaryContainer: Color(0xFF2E2E41),
  error: Color(0xFFD61409),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF410E0B),
  background: Color(0xFFF8F2EC),
  onBackground: Color(0xFF2E2E41),
  surface: Color(0xFFF8F2EC),
  onSurface: Color(0xFF2E2E41),
  surfaceVariant: Color(0xFFC7B0D7),
  onSurfaceVariant: Color(0xFF2E2E41),
  outline: Color(0xFFBBA48D),
  outlineVariant: Color(0xFFE2D7CC),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF2E2E41),
  inverseSurface: Color(0xFF2E2E41),
  onInverseSurface: Color(0xFFFDFCF7),
  inversePrimary: Color(0xFFFF8201),
  surfaceTint: Color(0xFF008088),
);


// --m3--sys--light--primary: #FF8201;
// --m3--sys--light--on-primary: #F8F2EC;
// --m3--sys--light--primary-container: #2E2E41;
// --m3--sys--light--on-primary-container: #F8F2EC;
// --m3--sys--light--primary-fixed: #EADDFF;
// --m3--sys--light--on-primary-fixed: #21005D;
// --m3--sys--light--primary-fixed-dim: #D0BCFF;
// --m3--sys--light--on-primary-fixed-variant: #4F378B;
// --m3--sys--light--secondary: #49499A;
// --m3--sys--light--on-secondary: #2E2E41;
// --m3--sys--light--secondary-container: #48486A;
// --m3--sys--light--on-secondary-container: #F8F2EC;
// --m3--sys--light--secondary-fixed: #E8DEF8;
// --m3--sys--light--on-secondary-fixed: #1D192B;
// --m3--sys--light--secondary-fixed-dim: #CCC2DC;
// --m3--sys--light--on-secondary-fixed-variant: #4A4458;
// --m3--sys--light--tertiary: #FA00FF;
// --m3--sys--light--on-tertiary: #FFFFFF;
// --m3--sys--light--tertiary-container: #FFD400;
// --m3--sys--light--on-tertiary-container: #2E2E41;
// --m3--sys--light--tertiary-fixed: #FFD8E4;
// --m3--sys--light--on-tertiary-fixed: #31111D;
// --m3--sys--light--tertiary-fixed-dim: #EFB8C8;
// --m3--sys--light--on-tertiary-fixed-variant: #633B48;
// --m3--sys--light--error: #D61409;
// --m3--sys--light--on-error: #FFFFFF;
// --m3--sys--light--error-container: #F9DEDC;
// --m3--sys--light--on-error-container: #410E0B;
// --m3--sys--light--outline: #BBA48D;
// --m3--sys--light--background: #F8F2EC;
// --m3--sys--light--on-background: #2E2E41;
// --m3--sys--light--surface: #F8F2EC;
// --m3--sys--light--on-surface: #2E2E41;
// --m3--sys--light--surface-variant: #C7B0D7;
// --m3--sys--light--on-surface-variant: #2E2E41;
// --m3--sys--light--inverse-surface: #2E2E41;
// --m3--sys--light--inverse-on-surface: #FDFCF7;
// --m3--sys--light--inverse-primary: #FF8201;
// --m3--sys--light--shadow: #000000;
// --m3--sys--light--surface-tint: #008088;
// --m3--sys--light--outline-variant: #E2D7CC;
// --m3--sys--light--scrim: #2E2E41;
// --m3--sys--light--surface-container-highest: #FFFFFF;
// --m3--sys--light--surface-container-high: #FFFDFA;
// --m3--sys--light--surface-container: #F8F2EC;
// --m3--sys--light--surface-container-low: #F5EFE8;
// --m3--sys--light--surface-container-lowest: #F8F2EC;
// --m3--sys--light--surface-bright: #FFFFFF;
// --m3--sys--light--surface-dim: #E1DBD8;